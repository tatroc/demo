## terraform.modules - Shared terraform modules

## Table Of Contents
- [Purpose](#purpose)
- [Branching](#branching)
- [Project Information](#project-information)

## Purpose
This repository contains the Terraform modules for every resource type which are commonly used to create any resource on Azure cloud. By creating these modules, we can reuse them for every project and resource without having to write the same code thereby reducing code foot print and standardizing and modularizing azure cloud resources.

## Branching
Since these are modules that are referred by other projects or resources, the code directly gets updated on the `master` branch. Just in case we need to verify anything, we always have the option to go for a Pull Request `PR` review and get it reviewed with the team and merge it with master.

## Project Information
| S.No. | Module Name | Purpose |
|------|-------------|--------------|
| 1. | aks | Module to create different azure kubernetes clusters |
| 2. | aks_roles | Module to create aks roles for different kubernetes cluster |
| 3. | azcdn | Module to create azure cdn |
| 4. | azcdn_endpoint | Module to create enpoints for created azure cdn |
| 5. | azcdn_profile | Module to create profile for azure cdn |
| 6. | azure service principal | Module to create service principles |
| 7. | azvms | Module to create azure virtual machines |
| 8. | cosmosdb | Module to create cosmos database |
| 9. | cosmosdb_single | Module to create a single cosmos database |
| 10.| cosmosdb_standard | Module to creata a standard cosmos database |
| 11.| functionapp |Module to create azure function app  |
| 12.| helm | Module to create helm and deploy helm on azure |
| 13.| keyvault | Module to create azure key vault |
| 14.| khe-eventbus | Module to create event bus on azure |
| 15.| loadbalancer | Module to create load balancer on azure |
| 16.| network_security_group | Module to create network security groups |
| 17.| network_security_rule | Module to create network security rule for the groups |
| 18.| peering | Module to create network peering |
| 19.| postgresdb | Module to create postgresql database |
| 20.| resource_group | Module to create a resource group |
| 21.| role_assignemnt | Module to create role assignment for a resource |
| 22.| storage_account | Module to create storage account |
| 23.| vnet-gateway-mesh | Module to create virtual network gateway mesh |
| 24.| vnet | Module to create virtual network |
| 25.| vnet_ignore_changes | Module to ignore changes done to virtual network |
