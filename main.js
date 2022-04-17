"use strict";

const pdfjsLib = require("pdfjs-dist/legacy/build/pdf.js");
const Worker = require("./worker.js");
const _ = require("lodash");
const YAML = require("yaml");
const fs = require("fs");

const pdfPath = process.argv[2] || "./CIS_Kubernetes_Benchmark_v1.6.0.pdf";
const BENCHMARK = "Kubernetes"; //"Kubernetes"; // EKS
//   "./CIS_Amazon_Elastic_Kubernetes_Service_(EKS)_Benchmark_v1.0.1.pdf"; //"./CIS_Kubernetes_Benchmark_v1.6.0.pdf";
const w = new Worker({ benchmark: BENCHMARK });

try {
  (async function () {
    const loadingTask = pdfjsLib.getDocument(pdfPath);
    const doc = await loadingTask.promise;
    const numPages = doc.numPages;
    console.log("# Document Loaded");
    console.log("Number of Pages: " + numPages);
    console.log();
    // Page 16
    // Page 12
    const B_PAGE = 17; //13; // 254; // 260; //17;
    // Page 261
    // Page 131
    const E_PAGE = 262; // 132; //255; // 261; //18;
    for (let pageNum = B_PAGE; pageNum <= E_PAGE; pageNum++) {
      const page = await doc.getPage(pageNum);
      const content = await page.getTextContent();
      // console.log("# Page " + pageNum);
      w.addItems(content.items, pageNum);
      page.cleanup();
    }
    const ruleObjs = w.Run();
    // if (fs.existsSync("./yamls")) fs.rmSync("./yamls", { recursive: true });
    // fs.mkdirSync("./yamls");
    ruleObjs.forEach((ruleObj) => {
      // console.log(ruleObj);
      const r_number = ruleObj.metadata.tags[2]
        .split(" ")[1]
        .replaceAll(".", "_");
      // ruleObj = _.omit(ruleObj, "metadata.tags");
      const yaml_doc = new YAML.Document();
      // console.log(doc.toString());
      if (
        fs.existsSync(
          `../csp-security-policies/compliance/cis_k8s/rules/cis_${r_number}`
        )
      ) {
        if (
          !fs.existsSync(
            `../csp-security-policies/compliance/cis_k8s/rules/cis_${r_number}/data.yaml`
          )
        ) {
          // console.log("JENIA NEW RULE", r_number);
          // yaml_doc.contents = ruleObj;
          // fs.writeFileSync(
          //   `../csp-security-policies/compliance/cis_k8s/rules/cis_${r_number}/data.yaml`,
          //   yaml_doc.toString()
          // );
        } else {
          if (
            r_number === "1_2_13" ||
            r_number === "5_1_3" ||
            r_number === "5_1_5" ||
            r_number === "5_1_6"
          ) {
            const exist_obj = YAML.parse(
              fs.readFileSync(
                `../csp-security-policies/compliance/cis_k8s/rules/cis_${r_number}/data.yaml`,
                "utf-8"
              )
            );
            const write_obj = _.defaultsDeep(ruleObj, exist_obj);
            yaml_doc.contents = write_obj;
            fs.writeFileSync(
              `../csp-security-policies/compliance/cis_k8s/rules/cis_${r_number}/data.yaml`,
              yaml_doc.toString()
            );
          }
        }
      }
    });
  })();
} catch (error) {
  console.error(err);
}
