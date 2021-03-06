<#include "GeneratorHelper.ftl">
<#--#####################################################################-->
<#--                                                                   ##-->
<#--         START OF THE OUTPUT                                       ##-->
<#--                                                                   ##-->
<#--#####################################################################-->
/* File:        ${file}
 * Generator:   ${generator} ${version}
 *
 * THIS FILE HAS BEEN GENERATED, PLEASE DO NOT EDIT!
 */
package ${package};

import javax.persistence.EntityManager;

import org.molgenis.data.jpa.JpaRepository;
import org.molgenis.data.validation.EntityValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("${JavaName(entity)}Repository")
public class ${JavaName(entity)}Repository extends JpaRepository
{	
	@Autowired
	public ${JavaName(entity)}Repository(EntityValidator entityValidator)
	{
		super(${JavaName(entity)}.class, new ${JavaName(entity)}MetaData(), entityValidator);
	}
	
    /**
	 * For testing purposes
	 */
	public ${JavaName(entity)}Repository(EntityManager entityManager, EntityValidator entityValidator)
	{
		super(entityManager, ${JavaName(entity)}.class, new ${JavaName(entity)}MetaData(), entityValidator);
	}
}