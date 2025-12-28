# Learning Session Template

**Date**: 2025-12-28 
**Topic**: Learning Terraform on GCP 
**Duration**: 2 hours  
**Difficulty**: Beginner

## 🎯 Objective

Learn the basics of terraform - infratructure as code. I want to setup a bucket on GCP on an existing project. 

Goals:
Understand how to provision infrastructure via terraform 
Understand the terraform syntax
Understand how to manage changes via terraform 

## 🤔 Questions to Explore

1. How do i connect / authenticate to GCP from the terminal with terraform ?
2. How do i integrate terraform with GIthub workflow 

## 📝 Notes and Learning

### Step 1: Installation ✅

**What I learned:**
- Terraform is not in Alpine's default repos, so we download the binary directly from HashiCorp
- Installed Terraform v1.10.3 successfully
- Command: `wget` + `unzip` + move to `/usr/local/bin/`

### Step 2: Understanding Terraform File Structure ✅

**Directory Setup:**
Created `/workspaces/life-long-learner/exercises/terraform-gcp-bucket/`

**Three Key Files:**

1. **`main.tf`** - Infrastructure definition
   ```hcl
   terraform {
     required_providers {
       google = {
         source  = "hashicorp/google"
         version = "~> 5.0"
       }
     }
   }
   
   provider "google" {
     project = var.project_id
     region  = var.region
   }
   
   resource "google_storage_bucket" "my_bucket" {
     name          = var.bucket_name
     location      = var.region
     force_destroy = true
     uniform_bucket_level_access = true
   }
   ```

2. **`variables.tf`** - Variable declarations
   ```hcl
   variable "project_id" {
     description = "GCP Project ID"
     type        = string
   }
   
   variable "bucket_name" {
     description = "Name of the GCS bucket"
     type        = string
   }
   ```

3. **`terraform.tfvars`** - Actual values (gitignored!)
   ```hcl
   project_id  = "my-gcp-project"
   bucket_name = "life-long-learning-bucket"
   region      = "europe-west1"
   ```

**Important concept learned:**
- `"my_bucket"` in `resource "google_storage_bucket" "my_bucket"` is the **Terraform identifier** (local reference only)
- `var.bucket_name` is the **actual GCP bucket name** (what appears in GCP Console)
- Like a variable name vs. its value in programming!

### Step 3: GCP Authentication ✅

**What I learned:**
- Terraform needs credentials to access GCP
- Two authentication methods:
  1. `gcloud auth application-default login` - for development
  2. Service Account key file - for production/CI/CD
- gcloud CLI and Terraform need separate authentication

**Commands used:**
```bash
gcloud auth application-default login
gcloud config set project YOUR-PROJECT-ID
```

### Step 4: Terraform Workflow ✅

**The Three Essential Commands:**

1. **`terraform init`**
   - Downloads provider plugins (GCP provider in our case)
   - Initializes backend for state management
   - Creates `.terraform/` directory
   - Only run once per project (or when adding new providers)

2. **`terraform plan`**
   - Shows what will change WITHOUT making changes
   - Dry run / preview mode
   - Look for `+` (create), `-` (delete), `~` (modify) symbols
   - Always run before apply!

3. **`terraform apply`**
   - Actually creates/modifies infrastructure
   - Asks for confirmation (type `yes`)
   - Creates/updates `terraform.tfstate` file
   - This makes REAL changes in GCP!

4. **`terraform destroy`** (cleanup)
   - Removes all managed infrastructure
   - Good for learning/testing to avoid charges

**Verification:**
```bash
terraform show  # View current state
gcloud storage ls  # Verify bucket exists
```

### Step 5: Devcontainer Configuration ✅

**Problem:** Codespaces don't preserve system installations between rebuilds

**Solution:** Configure `.devcontainer/devcontainer.json` and setup script

**What persists:**
- ✅ Files in `/workspaces/` directory
- ✅ Git commits
- ❌ System binaries (/usr/local/bin/)
- ❌ Manual installations

**Fix applied:**
- Created `.devcontainer/setup.sh` to auto-install Terraform and gcloud
- Set as `postCreateCommand` in devcontainer.json
- Now runs automatically on container rebuild

## 💻 Code Examples

### Complete GCP Bucket Configuration

See files in `/workspaces/life-long-learner/exercises/terraform-gcp-bucket/`

**Key Terraform Syntax Elements:**
- `terraform {}` block - configure Terraform itself
- `provider "google"` - configure GCP provider
- `resource "type" "name"` - define infrastructure
- `var.variable_name` - reference variables
- `force_destroy = true` - allow deletion of non-empty bucket (for learning)

## 🔍 Deep Dive

**Resource Naming in Terraform:**
- Terraform identifier vs. actual resource name was initially confusing
- `"my_bucket"` is just for Terraform to track the resource
- The actual name in GCP comes from the `name` property
- Used for referencing: `google_storage_bucket.my_bucket.url`

**State Management:**
- Terraform creates `terraform.tfstate` file
- Tracks what infrastructure currently exists
- Compares desired state (your .tf files) vs. actual state (AWS/GCP/etc.)
- **Important:** Never edit state file manually!
- Should be stored remotely for team collaboration (not covered yet)

**Alpine Linux vs Debian in Devcontainers:**
- Devcontainer features expect Debian/Ubuntu, not Alpine
- Alpine is lighter but has compatibility issues
- Solved by creating custom setup script for Alpine

## ✅ Key Takeaways

1. **Infrastructure as Code** - Define infrastructure in code files, version control them like any code
2. **Terraform Workflow** - Always: init → plan → review → apply → (optional: destroy)
3. **Declarative not Imperative** - You declare what you want, Terraform figures out how to get there
4. **Provider Pattern** - Terraform uses providers to interact with different cloud platforms
5. **Variable Separation** - Keep secrets/env-specific values in .tfvars (and gitignore them!)
6. **State is Critical** - Terraform's state file is the source of truth for what exists
7. **Plan Before Apply** - Always preview changes before executing them

## 🚧 Challenges Faced

- **Challenge:** Terraform not installed in Alpine Linux using standard package manager
  - **Solution:** Downloaded binary directly from HashiCorp releases
  - **Learning:** Not all tools are in every package manager; sometimes need manual install

- **Challenge:** Commands disappeared after codespace rebuild
  - **Solution:** Created devcontainer setup script that runs on container creation
  - **Learning:** Understand what persists vs. what needs configuration in cloud dev environments

- **Challenge:** gcloud authentication separate from Terraform authentication
  - **Solution:** Ran `gcloud auth application-default login` for Terraform, `gcloud auth login` for gcloud CLI
  - **Learning:** Different tools may need separate authentication even for the same cloud platform

- **Challenge:** Understanding difference between Terraform resource names and actual GCP names
  - **Solution:** Clarified that `"my_bucket"` is Terraform identifier, `name` property is actual GCP name
  - **Learning:** Local references vs. remote resource names are different concepts

## 🔗 Resources

- [Terraform GCP Provider Docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Terraform CLI Commands](https://developer.hashicorp.com/terraform/cli/commands)
- [GCP Storage Bucket Resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket)
- [HashiCorp Terraform Releases](https://releases.hashicorp.com/terraform/)
- [Google Cloud SDK Installation](https://cloud.google.com/sdk/docs/install)

## 📋 Action Items

- [x] Install Terraform
- [x] Install and configure gcloud CLI
- [x] Create main.tf with GCP provider and bucket resource
- [x] Create variables.tf to define input variables
- [x] Create terraform.tfvars with your GCP project ID
- [x] Run `terraform init` to initialize the project
- [x] Run `terraform plan` to see what will be created
- [x] Run `terraform apply` to create the bucket
- [x] Verify bucket creation with `terraform show`
- [x] Configure devcontainer for persistent installations
- [ ] Run `terraform destroy` to clean up when done
- [ ] Explore Terraform modules for reusability
- [ ] Learn about remote state storage (GCS backend)

## ➡️ Next Steps

What should I explore next based on today's learning?

1. **Answer remaining question:** How to integrate Terraform with GitHub Actions/Workflows
2. **Remote State:** Store terraform.tfstate in GCS bucket for team collaboration
3. **Terraform Modules:** Create reusable, parameterized infrastructure components
4. **Multi-resource project:** Deploy a complete application (Compute Engine + Storage + Networking)
5. **Terraform workspaces:** Manage multiple environments (dev, staging, prod)
6. **Import existing infrastructure:** Use `terraform import` to manage existing GCP resources

---

## 💭 Reflection

Brief reflection on the learning session:

**What worked well?**
- Hands-on approach - actually creating real infrastructure helped concepts stick
- Learning through troubleshooting (Alpine compatibility, authentication) was valuable
- Structured file organization (main.tf, variables.tf, tfvars) makes sense
- Terraform's plan/apply separation provides safety and confidence

**What could be improved?**
- Could have explored more resources (not just storage buckets)
- Didn't fully explore state management and remote backends
- Need to practice more with complex configurations and dependencies

**How confident do I feel with this topic?**
- **Basic workflows:** 8/10 - Comfortable with init, plan, apply workflow
- **Syntax:** 7/10 - Understand basics, need more practice with advanced features
- **Best practices:** 5/10 - Know some basics (gitignore tfvars) but need to learn more
- **Overall:** Ready to build simple infrastructure, need practice for complex scenarios
