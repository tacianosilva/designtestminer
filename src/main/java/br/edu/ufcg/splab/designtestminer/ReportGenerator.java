package br.edu.ufcg.splab.designtestminer;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.designwizard.design.ClassNode;
import org.designwizard.exception.InexistentEntityException;

public class ReportGenerator {

    private static Logger logger = LogManager.getLogger(ReportGenerator.class);

    private ReportGenerator() {
    }

    public static void main(String[] args) throws IOException, ClassNotFoundException, InexistentEntityException {
        logger.info("Start Main - Gerando Relatórios de Conformidade Arquitetural");

        //generateReportRandomSample();
        //generateReportStaredSample();
        generateReportEpol();
    }

    public static void generateReportRandomSample() {
        String fileName = "datasets/input/projects_sample_hibernate_2015-08-10.txt";
        String fileResults = "datasets/results/tests_results_sample.txt";
        String infoResults = "datasets/results/tests_info_sample.txt";

        processarArquivo(fileName, fileResults, infoResults);
    }

    public static void generateReportStaredSample() {
        String fileName = "datasets/input/projects_starred_hibernate_2015-08-30.txt";
        String fileResults = "datasets/results/tests_results_starred.txt";
        String infoResults = "datasets/results/tests_info_starred.txt";

        processarArquivo(fileName, fileResults, infoResults);
    }

    public static void generateReportEpol() {
        String fileName = "datasets/input/epol_version_8702.txt";
        String fileResults = "datasets/results/tests_results_epol.txt";
        String infoResults = "datasets/results/tests_info_epol.txt";

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
                logger.info("Processando projeto: " + linha);

                processarProjeto(linha, resultsWriter, infoWriter);

                linha = lerArq.readLine(); // lê da segunda até a última linha
            }

            arq.close();
            fw.close();
            infoFW.close();
        } catch (IOException e) {
            logger.error("Erro na abertura do arquivo: %s.%n", e);
        }
    }

    public static void processarProjeto(String projeto, PrintWriter resultsWriter, PrintWriter infoWriter) {
        String[] split = projeto.split("/");
        //String gitUser = split[0];
        //String projectName = split[1];
        String projectName = projeto;
        String reposDir = "/local_home/tacianosilva/workspace/";
        //String reposDir = "/home/taciano/dev/repos/";
        String classDir = getClassesDirectory(projeto);

        String projectDir = reposDir + projeto + classDir;

        try {
            logger.info("Diretório do Projeto: " + projectDir);
            logger.info("Diretório do Usuário: " + System.getProperty("user.dir"));
            DesignWizardDecorator dwd = new DesignWizardDecorator(projectDir, projectName);
            RulesVerifier verifier = new RulesVerifier(dwd);

            PrintWriter reportWriter = criarRelatorio("datasets/reports/tests_report_" + projectName + ".txt");

            int numClasses = dwd.getDesignWizard().getAllClasses().size();

            // Model Classes from Project
            Set<ClassNode> classes = dwd.getClassesByAnnotation("javax.persistence.Entity");

            int numModelClasses = classes.size();
            int numFailClasses = 0;

            for (ClassNode classNode : classes) {
                boolean passedClass = true;

                List<RuleResult> results = verifier.checkRules(classNode);

                for (RuleResult result : results) {

                    boolean passed = result.getResult();

                    passedClass = passedClass && passed;

                    logger.debug(">>>>>" + projeto + ", " + classNode.getClassName() + ", " + result.getRuleName() + ", " + passed);

                    gravarLinha(resultsWriter, projeto, result);

                    if (!passed) {
                        gravarLinhaRelatorio(reportWriter, projeto, result);
                    }
                }
                if (!passedClass) numFailClasses++;
            }

            // TODO Listar as classes que falharam
            //verifier.getFailClasses();
            // TODO Calcular o número de classes que falhou
            //verifier.getNumFailClasses();


            logger.debug(">>>>" + projeto + ", " + numClasses + ", " + numModelClasses + ", " + numFailClasses);
            gravarLinha(infoWriter, projeto, numClasses, numModelClasses, numFailClasses);

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }

    private static String getClassesDirectory(String projeto) {
        //TODO Detectar se o projeto é Maven ou Gradle. Detectar Diretório onde ficam os .class.
        if ("Raysmond/SpringBlog".equals(projeto)) {
            return "/build/classes/main/com/raysmond/blog/models";
        }
        if ("DanielMichalski/spring-web-rss-channels/rss-core".equals(projeto)) {
            return "/target/classes/pl/dmichalski/rss/core/entity";
        }
        if ("cliffmaury/angular-spring4-stack".equals(projeto)) {
            return "/target/classes/fr/valtech/angularspring/app/domain";
        }
        return "/target/classes";
    }

    private static void gravarLinha(PrintWriter gravar, String projeto, RuleResult result) {
        gravar.printf("%s,%s,%s,%s%n", projeto, result.getClassName(), result.getRuleName(), result.getResult());
    }

    private static void gravarLinhaRelatorio(PrintWriter reportWriter, String projeto, RuleResult result) {
        reportWriter.printf("%s,%s,%s,%n%s%n",
                projeto, result.getClassName(), result.getRuleName(), result.getRuleReport());
    }

    private static void gravarLinha(PrintWriter gravar, String projeto, int numClasses, int numModelClasses,
            int numFailClasses) {
        gravar.printf("%s,%d,%d,%d%n", projeto, numClasses, numModelClasses, numFailClasses);
    }

    public static FileWriter criarArquivo(String fileResults) throws IOException {
        FileWriter arq = new FileWriter(fileResults);
        return arq;
    }
}
