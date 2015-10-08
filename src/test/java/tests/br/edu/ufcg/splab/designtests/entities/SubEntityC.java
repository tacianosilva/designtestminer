package tests.br.edu.ufcg.splab.designtests.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@SuppressWarnings("serial")
@Entity
public class SubEntityC extends SuperEntityC {

    @Id
    private Integer id;

    @Column
    private String fieldSubEntity;

    protected Integer getId() {
        return id;
    }

    protected void setId(Integer param) {
        this.id = param;
    }

    protected String getFieldSubEntity() {
        return fieldSubEntity;
    }

    protected void setFieldSubEntity(String param) {
        this.fieldSubEntity = param;
    }
}
