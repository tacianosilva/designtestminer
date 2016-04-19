package br.edu.ufcg.splab.designtestminer;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

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

    public RulesVerifier(DesignWizardDecorator dwd) {
        this.dwd = dwd;
    }

    public RuleResult checkRule(AbstractDesignRule rule, ClassNode classNode) {
        rule.setClassNode(classNode);
        return createRuleResult(rule, classNode);
    }

    public List<RuleResult> checkRules(ClassNode classNode) {
        List<RuleResult> results = new LinkedList<>();

        for (AbstractDesignRule rule : getRules()) {
            results.add(checkRule(rule, classNode));
        }
        return results;
    }

    private RuleResult createRuleResult(AbstractDesignRule rule, ClassNode classNode) {
        return new RuleResult(rule.getName(), classNode.getName(), rule.checkRule(), rule.getReport());
    }

    public List<AbstractDesignRule> getRules() {
        List<AbstractDesignRule> regras = new ArrayList<AbstractDesignRule>();
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
