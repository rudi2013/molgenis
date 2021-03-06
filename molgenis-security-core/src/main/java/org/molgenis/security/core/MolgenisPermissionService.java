package org.molgenis.security.core;

public interface MolgenisPermissionService
{
	boolean hasPermissionOnPlugin(String pluginId, Permission permission);

	boolean hasPermissionOnEntity(String entityName, Permission permission);
}
