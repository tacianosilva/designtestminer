package tests.br.edu.ufcg.splab.designtestminer;

import java.util.Set;

import org.designwizard.api.DesignWizard;
import org.designwizard.design.PackageNode;
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
    String projectName = "desingtest";
    /**
     * Project jar file.
     */
    String arquivoJar = "target/classes";

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
        dw = dwd.getDesignWizard();
        softAssert.assertNotNull(dw, "test1");

        Set<PackageNode> packages = dw.getAllPackages();
        softAssert.assertEquals(packages.size(), 1, "test2");

        for (PackageNode packageNode : packages) {
            System.out.println("package" + packageNode);
        }

        softAssert.assertNotNull(dwd, "test3");
        softAssert.assertAll();
    }
}
