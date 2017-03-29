package br.edu.ufcg.splab.designtestminer;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.designwizard.api.DesignWizard;
import org.designwizard.design.ClassNode;

import br.edu.ufcg.splab.designtests.designrules.AbstractDesignRule;
import br.edu.ufcg.splab.designtests.designrules.HashCodeAndEqualsNotUseIdentifierPropertyRule;
import br.edu.ufcg.splab.designtests.designrules.HashCodeAndEqualsRule;
import br.edu.ufcg.splab.designtests.designrules.ImplementsSerializableRule;
import br.edu.ufcg.splab.designtests.designrules.NoArgumentConstructorRule;
import br.edu.ufcg.splab.designtests.designrules.NoFinalClassRule;
import br.edu.ufcg.splab.designtests.designrules.ProvideGetsSetsFieldsRule;
import br.edu.ufcg.splab.designtests.designrules.ProvideIdentifierPropertyRule;
import br.edu.ufcg.splab.designtests.designrules.UseSetCollectionRule;

public class RulesVerifier {

    private DesignWizardDecorator dwd;
    private Set<ClassNode> failClasses;

    public RulesVerifier(DesignWizardDecorator dwd) {
        this.dwd = dwd;
        this.failClasses = new HashSet<>();
    }

    public RuleResult checkRule(AbstractDesignRule rule, ClassNode classNode) {
        rule.setClassNode(classNode);
        return createRuleResult(rule, classNode);
    }

    public List<RuleResult> checkRules(ClassNode classNode) {
        List<RuleResult> results = new LinkedList<>();
        for (AbstractDesignRule rule : getRules()) {
            RuleResult result = checkRule(rule, classNode);
            if (!result.getResult()) {
                failClasses.add(classNode);
            }
            results.add(result);
        }
        return results;
    }

    public Set<ClassNode> getFailClasses() {
        return this.failClasses;
    }

    private RuleResult createRuleResult(AbstractDesignRule rule, ClassNode classNode) {
        return new RuleResult(rule.getName(), classNode.getName(), rule.checkRule(), rule.getReport());
    }

    /**
     * Returns a list of the Design Rules.
     * @return A list of the Design Rules.
     */
    public List<AbstractDesignRule> getRules() {
        List<AbstractDesignRule> regras = new ArrayList<>();
        DesignWizard dw = dwd.getDesignWizard();

        //Regras extraídas do manual Hibernate
        AbstractDesignRule rule1 = new NoArgumentConstructorRule(dw);
        regras.add(rule1);
        AbstractDesignRule rule2 = new ProvideIdentifierPropertyRule(dw);
        regras.add(rule2);
        AbstractDesignRule rule3 = new NoFinalClassRule(dw);
        regras.add(rule3);
        AbstractDesignRule rule4 = new ProvideGetsSetsFieldsRule(dw);
        regras.add(rule4);
        AbstractDesignRule rule5 = new HashCodeAndEqualsRule(dw);
        regras.add(rule5);

        // Alternativa recomendada para representar associações multivaloradas.
        AbstractDesignRule rule6 = new UseSetCollectionRule(dw);
        regras.add(rule6);
        // De acordo com a especificação do JPA
        AbstractDesignRule rule7 = new ImplementsSerializableRule(dw);
        regras.add(rule7);

        // Associação da Regra 2 com a regra 5
        AbstractDesignRule rule8 = new HashCodeAndEqualsNotUseIdentifierPropertyRule(dw);
        regras.add(rule8);

        return regras;
    }
}
