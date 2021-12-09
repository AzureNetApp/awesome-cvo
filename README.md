# Awesome Cloud Volumes ONTAP (CVO) - A curated list of Azure Cloud Volumes ONTAP Resources

- [Awesome Azure Cloud Volumes ONTAP (CVO) - A curated list of Azure Cloud Volumes ONTAP Resources](#awesome-azure-cloud-volumes-ontap-cvo---a-curated-list-of-azure-cloud-volumes-ontap-resources)
  - [General considerations for CVO in Azure](#general-considerations-for-CVO-in-Azure)
  - [How-To / Guides](#how-to--guides)
    - [Storage](#storage)
    - [Provision and Manage Storage](#provision-and-manage-storage)
    - [Installation Guides](#installation-guides)
  - [Blogs](#blogs)
  - [ONTAP Concepts](#ontap-concepts)
  - [Architecture](#architecture)
    - [Networking](#networking)
  - [Data Protection](#data-protection)
  - [Security](#security)
  - [Automation](#automation)
    - [Terraform](#terraform)
    - [Application Templates](#application-templates)
  - [Performance](#performance)
  - [Pricing](#pricing)

## General considerations for CVO in Azure

- [Azure CVO Deployment Playbook and Guide](https://github.com/felix-melligan/NetApp_Cloud_SE_Documentation/blob/main/Azure/Connector_Deployment.md)
- [Planning your CVO configuration in Azure](https://docs.netapp.com/us-en/occm/task_planning_your_config_azure.html)
- [Supported configuration](https://docs.netapp.com/us-en/cloud-volumes-ontap/reference_configs_azure_991.html)
- [Azure sizing guide](https://docs.netapp.com/us-en/occm/task_planning_your_config_azure.html#sizing-your-system-in-azure)
- [Azure storage limits](https://docs.netapp.com/us-en/cloud-volumes-ontap/reference_limits_azure_991.html)
- [Known limitations in Azure](https://docs.netapp.com/us-en/cloud-volumes-ontap/reference_limitations_azure_991.html)
- [Supported Regions](https://cloud.netapp.com/cloud-volumes-global-regions)
- [Setup CVO to use a customer managed key in Azure](https://docs.netapp.com/us-en/occm/task_set_up_azure_encryption.html)
- [Default configuration for CVO](https://docs.netapp.com/us-en/occm/reference_default_configs.html#defaults)

## How-to / Guides

### Storage

- [Disks and Aggregates](https://docs.netapp.com/us-en/occm/concept_storage.html)
- [Data Tiering](https://docs.netapp.com/us-en/occm/concept_data_tiering.html)
- [Storage Management](https://docs.netapp.com/us-en/occm/concept_storage_management.html)
- [Write Speed](https://docs.netapp.com/us-en/occm/concept_write_speed.html#recommendations-when-using-high-write-speed)
- [Flash Cache](https://docs.netapp.com/us-en/occm/concept_flash_cache.html)
- [WORM Storage](https://docs.netapp.com/us-en/occm/concept_worm.html)

### Provision and Manage Storage

- [Create volumes, aggregates, and LUNs](https://docs.netapp.com/us-en/occm/task_provisioning_storage.html)
- [Manage volumes and aggregates](https://docs.netapp.com/us-en/occm/task_managing_storage.html)
- [Tier inactive data to object storage](https://docs.netapp.com/us-en/occm/task_tiering.html)
- [Use ONTAP as Kubernetes storage](https://docs.netapp.com/us-en/occm/task_connecting_kubernetes.html)
- [Encrypt volumes with NetApp encryption](https://docs.netapp.com/us-en/occm/task_encrypting_volumes.html)
- [Manage Storage Virtual Machines](https://docs.netapp.com/us-en/occm/task_managing_svms_azure.html)

### Installation Guides

- [Getting Started with Cloud Volumes ONTAP in Azure: The Setup Walkthrough](https://cloud.netapp.com/blog/a-step-by-step-guide-to-setting-up-cloud-volumes-ontap-on-azure)
- [Step-by-step guide to setting up CVO in Azure](https://cloud.netapp.com/blog/a-step-by-step-guide-to-setting-up-cloud-volumes-ontap-on-azure)
- [Step-by-step guide with video for SaaS based Cloud Manager setup](https://cloud.netapp.com/step-by-step-guide-azure-cvo-lp#1)

## Blogs

- [Azure latency reductions with Cloud Volumes ONTAP and NVMe Caching](https://cloud.netapp.com/blog/azure-cvo-blg-azure-latency-reductions-with-cloud-volumes-ontap)
- [SVM-DR](https://www.netapp.com/blog/simplified-svm-level-data-protection-using-oncommand-system-manager-9-5/)
- [How to deploy Cloud Volumes ONTAP using NetApp Cloud Manager Terraform Provider](https://cloud.netapp.com/blog/cvo-blg-setting-up-cloud-volumes-ontap-with-the-terraform-provider)
- [Terraform & Cloud Manager: How to Use Cloud Manager Terraform Provider](https://cloud.netapp.com/blog/cvo-blg-terraform-cloud-manager-terraform-provider)


## ONTAP Concepts

- [Flex Cache](https://www.netapp.com/knowledge-center/what-is-flex-cache/)
- [Snapshots](https://docs.netapp.com/ontap-9/index.jsp?topic=%2Fcom.netapp.doc.dot-cm-concepts%2FGUID-BE5710C9-AA51-4D91-9FE8-8F5642B79297.html)

## Architecture

- [HA pairs in Azure](https://docs.netapp.com/us-en/occm/concept_ha_azure.html)
- [CVO sizer](https://github.dev/AzureNetApp/awesome-cvo)

### Networking

- [Networking requirements in Azure:](https://docs.netapp.com/us-en/occm/reference_networking_azure.html)

## Data Protection

- [Learn about the replication service](https://docs.netapp.com/us-en/occm/concept_replication.html)
- [Replicating data between systems](https://docs.netapp.com/us-en/occm/task_replicating_data.html)
- [Manage data replication schedules and relationships](https://docs.netapp.com/us-en/occm/task_managing_replication.html)
- [Learn about replication policies](https://docs.netapp.com/us-en/occm/concept_replication_policies.html)

## Security

- [CVO Security](https://docs.netapp.com/us-en/occm/concept_security.html)

## Automation

### Terraform

- [Terraform: netapp-cloudmanager_cvo_azure [docs]](https://registry.terraform.io/providers/NetApp/netapp-cloudmanager/latest/docs/resources/cvo_azure)

### Application Templates

- [Learn about applicaton templates](https://docs.netapp.com/us-en/occm/concept_resource_templates.html)
- [Template building blocks](https://docs.netapp.com/us-en/occm/reference_template_building_blocks.html)
- [Build application templates for your organization](https://docs.netapp.com/us-en/occm/task_define_templates.html)
- [Check resources for template compliance](https://docs.netapp.com/us-en/occm/task_check_template_compliance.html)
- [Run templates to create resources](https://docs.netapp.com/us-en/occm/task_run_templates.html)

## Performance

- [Performance characterization of NetApp Cloud Volumes ONTAP for Azure with application workloads TR-4671](https://www.netapp.com/pdf.html?item=/media/9089-tr-4671pdf.pdf)

## Pricing
- [Azure CVO Pricing Guide](https://cloud.netapp.com/azure-calculator)
- [Azure Manged Disk pricing](https://azure.microsoft.com/en-us/pricing/details/managed-disks/)
- [Azure Page Blob pricing](https://azure.microsoft.com/en-us/pricing/details/storage/page-blobs/)