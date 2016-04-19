package br.edu.ufcg.splab.designtestminer;

public class RuleResult {

    private String ruleName;

    private Boolean result;

    private String className;

    private String ruleReport;

    public RuleResult(String ruleName, String className, boolean result, String ruleReport) {
        this.ruleName = ruleName;
        this.className = className;
        this.result = result;
        this.ruleReport = ruleReport;
    }

    public String getRuleName() {
        return ruleName;
    }

    public Boolean getResult() {
        return result;
    }

    public String getClassName() {
        return className;
    }

    public String getRuleReport() {
        return ruleReport;
    }
}
