package br.edu.ufcg.splab.designtestminer;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.designwizard.api.DesignWizard;
import org.designwizard.design.ClassNode;
import org.designwizard.exception.InexistentEntityException;

import br.edu.ufcg.splab.designtests.designrules.AbstractDesignRule;
import br.edu.ufcg.splab.designtests.designrules.HashCodeAndEqualsNotUseIdentifierPropertyRule;
import br.edu.ufcg.splab.designtests.designrules.HashCodeAndEqualsRule;
import br.edu.ufcg.splab.designtests.designrules.ImplementsSerializableRule;
import br.edu.ufcg.splab.designtests.designrules.NoArgumentConstructorRule;
import br.edu.ufcg.splab.designtests.designrules.NoFinalClassRule;
import br.edu.ufcg.splab.designtests.designrules.ProvideGetsSetsFieldsRule;
import br.edu.ufcg.splab.designtests.designrules.ProvideIdentifierPropertyRule;
import br.edu.ufcg.splab.designtests.designrules.UseInterfaceSetOrListRule;
import br.edu.ufcg.splab.designtests.designrules.UseSetCollectionRule;

public class EPolRulesVerifier {

    public static void main(String[] args) throws IOException, ClassNotFoundException, InexistentEntityException {
        System.out.printf("%nConteúdo do arquivo projectsThatUseHibernate.txt%n%n");

        String fileName = "scripts/epol_versions.txt";
        String fileResults = "scripts/tests_results_epol.txt";
        String infoResults = "scripts/tests_info_epol.txt";

        processarArquivo(fileName, fileResults, infoResults);
    }

    public static PrintWriter criarRelatorio(String reportName) throws IOException {
        FileWriter fw = criarArquivo(reportName);
        PrintWriter reportWriter = new PrintWriter(fw);
        reportWriter.printf("%s,%s,%s,%s%n", "project", "class", "rule", "report");

        return reportWriter;
    }

    public static void processarArquivo(String fileProjects, String fileResults, String infoResults) {
        try {
            FileReader arq = new FileReader(fileProjects);
            BufferedReader lerArq = new BufferedReader(arq);

            FileWriter fw = criarArquivo(fileResults);
            PrintWriter resultsWriter = new PrintWriter(fw);
            resultsWriter.printf("%s,%s,%s,%s%n", "project", "class", "rule", "result");

            FileWriter infoFW = criarArquivo(infoResults);
            PrintWriter infoWriter = new PrintWriter(infoFW);
            infoWriter.printf("%s,%s,%s,%s%n", "project", "num classes", "num model classes", "num fail classes");

            String linha = lerArq.readLine(); // lê a primeira linha
            // a variável "linha" recebe o valor "null" quando o processo
            // de repetição atingir o final do arquivo texto
            while (linha != null) {
                System.out.printf("%s\n", linha);

                processarProjeto(linha, resultsWriter, infoWriter);

                linha = lerArq.readLine(); // lê da segunda até a última linha
            }

            arq.close();
            fw.close();
            infoFW.close();
        } catch (IOException e) {
            System.err.printf("Erro na abertura do arquivo: %s.%n", e.getMessage());
        }
    }

    public static void processarProjeto(String projeto, PrintWriter resultsWriter, PrintWriter infoWriter) {
        String[] split = projeto.split(":");
        String version = "epol-"+split[0];
        //String commit = split[1];
        //String dev = split[2];
        //String data = split[3];
        String reposDir = "/home/taciano/dev/epol_versions/";
        String classDir = getClassesDirectory(reposDir, projeto);

        String projectDir = reposDir + version + classDir;

        try {
            System.out.println("Diretório do Projeto: " + projectDir);
            DesignWizardDecorator dwd = new DesignWizardDecorator(projectDir, version);

            PrintWriter reportWriter = criarRelatorio("scripts/tests_report_" + version + ".txt");

            int numClasses = dwd.getDesignWizard().getAllClasses().size();

            DesignWizard dw = dwd.getDesignWizard();

            Set<ClassNode> anotacoes = dw.getAllAnnotations();
            for (ClassNode classNode : anotacoes) {
                System.out.println("Anotação: " + classNode.getName());
            }

            ClassNode entity = dw.getClass("javax.persistence.Entity");
            System.out.println("Entity: " + entity.getName());
            System.out.println("Modifiers " + entity.getModifiers());

            ClassNode caso = dw.getClass("br.gov.dpf.epol.pojo.caso.Caso");
            System.out.println("Caso Entity: " + caso.getName());
            System.out.println("Anotações: " + caso.getAnnotations().contains(entity));
            System.out.println("Modifiers: " + caso.getModifiers());

            // Model Classes from Project
            Set<ClassNode> classes = dwd.getClassesByAnnotation("javax.persistence.Entity");
            int numModelClasses = classes.size();


            List<AbstractDesignRule> regras = getRegras(dwd.getDesignWizard());
            int numFailClasses = 0;

            for (ClassNode classNode : classes) {
                boolean passedClass = true;
                for (AbstractDesignRule rule : regras) {
                    rule.setClassNode(classNode);
                    String ruleName = rule.getName();
                    boolean passed = rule.checkRule();

                    passedClass = passedClass && passed;

                    System.out.println(">>>>>" + projeto + ", " + classNode.getClassName() + ", " + ruleName + ", " + passed);
                    System.out.println("Report Rule: " + ruleName);
                    System.out.println(rule.getReport());

                    gravarLinha(resultsWriter, projeto, classNode.getClassName(), ruleName, passed);
                    if (!passed) {
                        reportWriter.printf("%s,%s,%s,\n%s\n", projeto, classNode.getClassName(), ruleName, rule.getReport());
                    }
                }
                if (!passedClass) numFailClasses++;
            }

            System.out.println(">>>>" + projeto + ", " + numClasses + ", " + numModelClasses + ", " + numFailClasses);
            gravarLinha(infoWriter, projeto, numClasses, numModelClasses, numFailClasses);

        } catch (IOException ioe) {
            ioe.printStackTrace();
        } catch (ClassNotFoundException ce) {
            ce.printStackTrace();
        } catch (InexistentEntityException e) {
            e.printStackTrace();
        } catch (ArrayIndexOutOfBoundsException e) {
            e.printStackTrace();
        }
    }

    private static String getClassesDirectory(String repo, String projeto) {
        return "/target/classes/";
        //return "/target/classes/br/gov/dpf/epol/pojo/";
    }

    private static void gravarLinha(PrintWriter gravar, String projeto, String className, String ruleName,
            boolean checkResult) {
        gravar.printf("%s,%s,%s,%s%n", projeto, className, ruleName, checkResult);
    }

    private static void gravarLinha(PrintWriter gravar, String projeto, int numClasses, int numModelClasses,
            int numFailClasses) {
        gravar.printf("%s,%d,%d,%d%n", projeto, numClasses, numModelClasses, numFailClasses);
    }

    private static List<AbstractDesignRule> getRegras(DesignWizard dw) {
        List<AbstractDesignRule> regras = new ArrayList<AbstractDesignRule>();

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

        // Recomendação de utilização uso de interfaces na declaração do tipo de coleção
        AbstractDesignRule rule6 = new UseInterfaceSetOrListRule(dw);
        regras.add(rule6);
        // Alternativa recomendada para representar associações multivaloradas.
        AbstractDesignRule rule6a = new UseSetCollectionRule(dw);
        regras.add(rule6a);
        // De acordo com a especificação do JPA
        AbstractDesignRule rule7 = new ImplementsSerializableRule(dw);
        regras.add(rule7);

        // Associação da Regra 2 com a regra 5
        AbstractDesignRule rule8 = new HashCodeAndEqualsNotUseIdentifierPropertyRule(dw);
        regras.add(rule8);

        return regras;
    }

    public static FileWriter criarArquivo(String fileResults) throws IOException {
        FileWriter arq = new FileWriter(fileResults);
        return arq;
    }
}