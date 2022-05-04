"use strict";

const _ = require("lodash");
const fs = require("fs");
const YAML = require("yaml");
const path = require("path")

const CSP_PATH = "../csp-security-policies";

(async function () {
    const rules = fs.readdirSync(
        path.join(CSP_PATH,"/compliance/cis_k8s/rules/")
    );
    rules.forEach((rule) => {
        const yaml_doc = new YAML.Document();
        const exist_raw_rule = fs.readFileSync(
            path.join(CSP_PATH,`compliance/cis_k8s/rules/${rule}/data.yaml`),
            "utf-8"
        );
        const rule_obj = YAML.parse(exist_raw_rule).metadata;
        rule_obj.enabled = true;
        rule_obj.muted = false;
        rule_obj.rego_rule_id = rule;
        const integration_rule = {id: rule_obj.id, type: 'csp-rule-template', attributes: rule_obj}
        console.log(`${integration_rule}`);
        fs.writeFileSync(
            path.join(`../integrations/packages/cloud_security_posture/kibana/csp_rule_template/`,`${integration_rule.id}.json`),
            JSON.stringify(integration_rule, null, 4),
            "utf-8"
        );
    });
})();