package tests.br.edu.ufcg.splab.designtestminer;

import java.util.Set;

import org.designwizard.api.DesignWizard;
import org.designwizard.design.ClassNode;
import org.designwizard.design.PackageNode;
import org.designwizard.exception.InexistentEntityException;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;
import org.testng.asserts.SoftAssert;

import br.edu.ufcg.splab.designtestminer.DesignWizardDecorator;

/**
 * Test class for {@link DesignWizardDecorator}.
 * @author Taciano de Morais Silva - tacianosilva@gmail.com
 */
@Test
public class DesignWizardDecoratorTest {

    /**
     * DesignWizard instance.
     */
    DesignWizard dw;

    /**
     * Decorator instance.
     */
    DesignWizardDecorator dwd;

    /**
     * Project name on the tests.
     */
    String projectName = "designtestminer";

    /**
     * Project jar file.
     */
    String arquivoJar = "target/test-classes";

    private SoftAssert softAssert;

    @BeforeClass
    public void setUp() throws Exception {
        dwd = new DesignWizardDecorator(arquivoJar, projectName);
    }

    @BeforeMethod
    public void startTest() {
         softAssert = new SoftAssert();
    }

    @AfterClass
    public void tearDown() throws Exception {
        dw = null;
        dwd = null;
    }

    @Test
    public final void testNewDesignWizardDecorator() {

        softAssert.assertNotNull(dwd, "test1");

        dw = dwd.getDesignWizard();
        softAssert.assertNotNull(dw, "test2");

        Set<PackageNode> packages = dw.getAllPackages();
        softAssert.assertEquals(packages.size(), 3, "test3");

        for (PackageNode packageNode : packages) {
            System.out.println("package" + packageNode);
        }

        softAssert.assertEquals(dwd.getProjectName(), "designtestminer", "test4");

        softAssert.assertAll();
    }

    @Test
    public void testAllAnnotations() {
        Set<ClassNode> annotations = dwd.getAllAnnotations();
        for (ClassNode classNode : annotations) {
            System.out.println("Annotation: " + classNode.getName());
        }
        softAssert.assertNotNull(annotations.size());
        softAssert.assertEquals(annotations.size(), 6);
        softAssert.assertAll();
    }

    @Test
    public void testGetClassesByAnnotation() {
        try {
            Set<ClassNode> annotatedA = dwd.getClassesByAnnotation("tests.br.edu.ufcg.splab.designtestminer.mocks.annotations.AnnotationA");
            softAssert.assertNotNull(annotatedA);
            softAssert.assertEquals(annotatedA.size(), 2);

            Set<ClassNode> annotatedB = dwd.getClassesByAnnotation("tests.br.edu.ufcg.splab.designtestminer.mocks.annotations.AnnotationB");
            softAssert.assertNotNull(annotatedB);
            softAssert.assertEquals(annotatedB.size(), 0);
        } catch (InexistentEntityException e) {
            softAssert.fail("Error by exception!", e);
        }

        softAssert.assertAll();
    }

    @Test
    public void testGetClass() {

        try {
            ClassNode classA = dwd.getClass("tests.br.edu.ufcg.splab.designtestminer.mocks.ClassA");
            softAssert.assertNotNull(classA);
            softAssert.assertEquals(classA.getName(), "tests.br.edu.ufcg.splab.designtestminer.mocks.ClassA");

            ClassNode classB = dwd.getClass("tests.br.edu.ufcg.splab.designtestminer.mocks.ClassB");
            softAssert.assertNotNull(classB);
            softAssert.assertEquals(classB.getName(), "tests.br.edu.ufcg.splab.designtestminer.mocks.ClassB");
        } catch (InexistentEntityException e) {
            softAssert.fail("Error by exception!", e);
        }

        softAssert.assertAll();
    }

    @Test(expectedExceptions=InexistentEntityException.class)
    public void testGetClassException() throws InexistentEntityException {
        ClassNode classD = dwd.getClass("tests.br.edu.ufcg.splab.designtestminer.mocks.ClassD");
        softAssert.assertNull(classD);
        softAssert.assertAll();
    }

    @Test
    public void testGetAnnotation() {

        try {
            ClassNode annotationA = dwd.getAnnotation("tests.br.edu.ufcg.splab.designtestminer.mocks.annotations.AnnotationA");
            softAssert.assertNotNull(annotationA);
            softAssert.assertTrue(annotationA.isAnnotation());

            ClassNode annotationB = dwd.getAnnotation("tests.br.edu.ufcg.splab.designtestminer.mocks.annotations.AnnotationB");
            softAssert.assertNotNull(annotationB);
            softAssert.assertTrue(annotationB.isAnnotation());
        } catch (InexistentEntityException e) {
            softAssert.fail("Error by exception!", e);
        }

        softAssert.assertAll();
    }

    @Test(expectedExceptions=InexistentEntityException.class)
    public void testGetAnnotationException() throws InexistentEntityException {
        ClassNode annotationC = dwd.getAnnotation("tests.br.edu.ufcg.splab.designtestminer.mocks.annotations.AnnotationC");
        softAssert.assertNull(annotationC);
        softAssert.assertAll();
    }
}
