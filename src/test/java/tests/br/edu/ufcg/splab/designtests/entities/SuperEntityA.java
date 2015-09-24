package tests.br.edu.ufcg.splab.designtests.entities;

import java.io.Serializable;

import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public class SuperEntityA implements Serializable {

    /**
     * serialVersionUID.
     */
    private static final long serialVersionUID = 1L;

    @Id
    private String fieldSuperEntity;

    protected String getMethodSuperEntity() {
        return fieldSuperEntity;
    }

    protected void setMethodSuperEntity(String param) {
        this.fieldSuperEntity = param;
    }

}
