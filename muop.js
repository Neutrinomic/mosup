import fs from "node:fs";
import path from "node:path";

const [inputFilePath] = Deno.args.slice(-1);

if (!inputFilePath?.endsWith('.mu.mo')) {
  console.error("Input file must have the extension .mu.mo");
  Deno.exit(1);
}

const outputFilePath = inputFilePath.replace(/\.mu\.mo$/, ".mo");

try {
  const content = fs.readFileSync(inputFilePath, "utf-8");
  fs.writeFileSync(outputFilePath, process(content));
  console.log(`Successfully wrote to ${outputFilePath}`);
} catch (error) {
  console.error("Error processing file:", error);
  Deno.exit(1);
}

function process(content) {
  // Scan for all occurrences of MU.persistent("...any_id") and save them in an array
  const matches = [...content.matchAll(/MU\.persistent\("(.*?)"\)/g)].map(match => match[1]);
  console.log("Found persistent IDs:", matches);

  let additionalContent = "";
  let importStatements = "";
  const memObjects = {};

  matches.forEach(id => {
    const dirPath = path.join(path.dirname(inputFilePath), "./mo_dules", id, "memory");
    if (fs.existsSync(dirPath)) {
      const files = fs.readdirSync(dirPath);
      const versionNumbers = files
        .map(file => file.match(/^v(\d+)\.mo$/))
        .filter(match => match)
        .map(match => parseInt(match[1]))
        .sort((a, b) => b - a);
      console.log(`Found versions for ID '${id}':`, versionNumbers);

      if (versionNumbers.length >= 2) {
        const latestVersion = versionNumbers[0];
        const previousVersion = versionNumbers[1];

        additionalContent += `
    stable let mem_${id}_${previousVersion} : MU.MemShell<MU_${id}_mem${previousVersion}.Mem> = { var inner = null };

    stable let mem_${id}_${latestVersion} : MU.MemShell<MU_${id}_mem${latestVersion}.Mem> = { var inner = do ? { MU_${id}_mem${latestVersion}.patch(mem_${id}_${previousVersion}.inner!) } };
    
    mem_${id}_${previousVersion}.inner := null;
        `;

        importStatements += `import MU_${id}_mem${previousVersion} "./mo_dules/${id}/memory/v${previousVersion}";
`;
        importStatements += `import MU_${id}_mem${latestVersion} "./mo_dules/${id}/memory/v${latestVersion}";
`;

        memObjects[id] = `mem_${id}_${latestVersion}`;
      } else if (versionNumbers.length === 1) {
        const onlyVersion = versionNumbers[0];

        additionalContent += `
    stable let mem_${id}_${onlyVersion} : MU.MemShell<MU_${id}_mem${onlyVersion}.Mem> = { var inner = null };
        `;

        importStatements += `import MU_${id}_mem${onlyVersion} "./mo_dules/${id}/memory/v${onlyVersion}";
`;

        memObjects[id] = `mem_${id}_${onlyVersion}`;
      }
    } else {
      console.warn(`Directory not found for ID '${id}':`, dirPath);
    }
  });

  // Replace MU.placeholder() with additionalContent
  let updatedContent = importStatements + content.replace(/MU\.placeholder\(\)\s*;/, additionalContent);

  // Replace MU.persistent("one") with the corresponding memory object using String.prototype.replace
  for (const [id, memObject] of Object.entries(memObjects)) {
    updatedContent = updatedContent.replaceAll(`MU.persistent("${id}")`, memObject);
  }

  return updatedContent;
}