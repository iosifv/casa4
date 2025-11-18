# CLAUDE.md - AI Assistant Documentation

This document provides comprehensive information about the Casa4 project for AI assistants like Claude Code.

## Project Overview

**Casa4** is a personal portfolio/business card website for Casa4 Ltd - a freelance IT engineering consultancy. The project is intentionally "overengineered" for learning and training purposes, showcasing modern DevOps and infrastructure practices.

- **Live Site:** https://casa4.co.uk/
- **Type:** Static website with terminal/shell theme
- **Purpose:** Professional portfolio showcasing IT engineering services

## Tech Stack

### Frontend & Content
- **Hugo** (v0.95.0+) - Static site generator (extended version required for SCSS)
- **Hugo Theme:** Shell theme (terminal-style UI) - managed as git submodule
- **CSS/SCSS:** Custom styling with Molokai color scheme
- **JavaScript:** Custom typewriter animation for terminal effects

### Infrastructure
- **Terraform** (v1.0+) - Infrastructure as Code
- **AWS S3** - Static site hosting (us-east-1 region)
- **Cloudflare** - DNS management and HTTPS enforcement
- **GitHub Actions** - CI/CD pipeline

### Key AWS Resources
- Two S3 buckets (apex domain + www subdomain)
- S3 website configuration with public read access
- www bucket redirects to main domain

### Key Cloudflare Resources
- DNS CNAME records pointing to S3 endpoints
- Page rules for HTTPS redirect (301)
- Custom redirect for `/learn` path

## Project Structure

```
casa4/
├── .github/workflows/
│   └── deploy-all.yml          # CI/CD pipeline
├── casa4-website/              # Hugo site root
│   ├── config.toml             # Hugo configuration (extensive comments)
│   ├── content/                # Markdown content
│   │   ├── description.md      # Main profile/bio
│   │   ├── description2.md     # Secondary description
│   │   ├── projects.md         # Projects showcase
│   │   └── posts/              # Blog posts
│   ├── data/
│   │   └── themes.json         # Terminal color schemes
│   ├── layouts/partials/
│   │   ├── style.html          # Terminal color CSS
│   │   └── typeIndex.html      # Typewriter animation
│   ├── themes/shell/           # Git submodule (Hugo theme)
│   ├── public/                 # Generated static files (not in git)
│   └── resources/_gen/         # Hugo generated assets
├── main.tf                     # Terraform AWS/Cloudflare resources
├── providers.tf                # Terraform provider configuration
├── variables.tf                # Terraform input variables
├── outputs.tf                  # Terraform outputs
├── terraform.tfvars            # Terraform variable values (not in git)
├── upload-to-s3.sh             # Manual S3 upload script
└── README.md                   # User-facing documentation
```

## Development Workflow

### Local Development

**Start Hugo development server:**
```bash
cd casa4-website && hugo server -w -D
```
- Runs on http://localhost:1313
- Auto-reloads on file changes (-w)
- Shows draft posts (-D)

**Build static site locally:**
```bash
cd casa4-website && hugo
```
- Generates site to `public/` directory
- Use for testing before deployment

### Content Management

**Add new blog post:**
```bash
cd casa4-website
hugo new posts/my-new-post.md
```
- Creates post with front matter template
- Edit in `content/posts/my-new-post.md`
- Set `draft: false` to publish

**Edit existing content:**
- All content in `casa4-website/content/`
- Markdown format with YAML front matter
- Can use online editors like Prose.io

### Theme Customization

**Terminal color scheme:**
- Defined in `casa4-website/data/themes.json`
- Current: Molokai (dark theme)
- Other options: Shell-PowerShell, Shell-Ubuntu, Shell-Retro, Gogh themes

**Animation speeds (in config.toml):**
- `ps1Delay`: Prompt typing speed (default: 1ms)
- `stdoutDelay`: Output typing speed (default: 1ms)
- `commandDelay`: Command typing speed (default: 50ms)
- Set to 0 to disable animations

### Git Submodules

**The Hugo theme is a git submodule:**
```bash
# Clone with submodules
git clone --recursive <repo-url>

# Or initialize after clone
git submodule update --init --recursive

# Update theme to latest
cd casa4-website/themes/shell
git pull origin main
cd ../../..
git add casa4-website/themes/shell
git commit -m "Update Hugo theme"
```

## Infrastructure Management

### Terraform Workflow

**Current state:** Remote backend in Terraform Cloud
- Organization: `iosifv`
- Workspace: `casa4`

**Common Terraform commands:**
```bash
# Format code
terraform fmt

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes (use with caution)
terraform apply

# Show current state
terraform show
```

**Important:** Infrastructure changes are typically deployed via GitHub Actions, not manually.

### AWS Configuration

**S3 Buckets:**
- Main: `casa4.co.uk` (hosts the site)
- WWW: `www.casa4.co.uk` (redirects to main)
- Region: us-east-1
- Public read access enabled
- Website hosting enabled

**Required AWS credentials:**
- Stored as GitHub Secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`
- Used by GitHub Actions for deployment

### Cloudflare Configuration

**DNS Records:**
- CNAME for apex domain → S3 endpoint
- CNAME for www → S3 endpoint

**Page Rules:**
- HTTPS enforcement (HTTP → HTTPS 301 redirect)
- Custom redirect for `/learn` path

## CI/CD Pipeline

### GitHub Actions Workflow

**Location:** `.github/workflows/deploy-all.yml`

**Trigger:** Runs on every push to repository

**Jobs:**

1. **Validation Job** (terraform-validation)
   - Checks Terraform formatting
   - Validates Terraform configuration
   - Runs before deploy

2. **Build & Deploy Job** (build-and-deploy)
   - Checks out code with submodules
   - Sets up Hugo (extended version v0.115.4)
   - Builds static site with `hugo` command
   - Syncs `public/` to S3 bucket
   - Uses AWS credentials from secrets

**Required GitHub Secrets:**
- `AWS_ACCESS_KEY_ID` - AWS access key
- `AWS_SECRET_ACCESS_KEY` - AWS secret key
- `TF_API_TOKEN` - Terraform Cloud API token (if modifying Terraform)

### Manual Deployment

**Using the upload script:**
```bash
./upload-to-s3.sh
```
- Builds Hugo site
- Uploads to S3 bucket
- Requires AWS CLI configured locally

## Common Tasks

### Update Site Content

1. Edit markdown files in `casa4-website/content/`
2. Test locally with `hugo server -w -D`
3. Commit and push changes
4. GitHub Actions automatically deploys

### Change Terminal Theme

1. Edit `casa4-website/data/themes.json` to add new theme
2. Update `casa4-website/config.toml` → `[Params]` → `colorscheme`
3. Test with Hugo server
4. Commit and push

### Modify Site Configuration

1. Edit `casa4-website/config.toml`
2. Key settings:
   - `baseURL` - Site URL
   - `title` - Site title
   - `[Params]` - Terminal behavior, theme, delays
   - `[[Params.tree.list]]` - Navigation links
3. Test locally before pushing

### Update Infrastructure

1. Modify Terraform files (`main.tf`, `variables.tf`, etc.)
2. Run `terraform fmt` to format
3. Run `terraform validate` to check
4. Run `terraform plan` to preview changes
5. Commit and push (validation runs in CI)
6. Apply changes manually or via CI (be careful!)

### Troubleshooting Hugo Build

**Common issues:**

- **"Hugo not found"** - Install Hugo extended version
- **SCSS errors** - Requires Hugo extended (not standard)
- **Submodule missing** - Run `git submodule update --init --recursive`
- **Old content showing** - Clear `public/` and `resources/_gen/`, rebuild

### Troubleshooting Terraform

**Common issues:**

- **State lock** - Check Terraform Cloud workspace
- **Provider version** - Check `.terraform.lock.hcl`
- **AWS credentials** - Ensure correct credentials in environment
- **Remote state** - Ensure `providers.tf` has correct cloud config

## Important Configuration Files

### config.toml (casa4-website/config.toml)

Key sections:
- `baseURL` - Must match production domain
- `theme = "shell"` - References theme in themes/ directory
- `[Params]` - Terminal appearance and behavior
  - `ps1Delay`, `stdoutDelay`, `commandDelay` - Animation speeds
  - `colorscheme` - Terminal color theme
  - `description` - Shell prompt text
  - `startxLocation` - Path shown in prompt
- `[[Params.tree.list]]` - Navigation links (directory tree style)

### main.tf

Defines:
- Two S3 buckets with website configuration
- Bucket policies for public read access
- Cloudflare DNS records (CNAME)
- Cloudflare page rules (HTTPS, redirects)

### providers.tf

Configures:
- Terraform Cloud backend (remote state)
- AWS provider (region: us-east-1)
- Cloudflare provider
- Random provider

### deploy-all.yml

CI/CD pipeline that:
- Validates Terraform on every push
- Builds Hugo site
- Deploys to S3 automatically

## Best Practices for AI Assistants

### When Making Changes

1. **Content changes:** Edit files in `casa4-website/content/`, test with Hugo server
2. **Theme changes:** Prefer editing `data/themes.json` or `config.toml` over theme files
3. **Infrastructure changes:** Run `terraform validate` before committing
4. **Always test locally** before committing (use `hugo server -w -D`)

### File Operations

- **Never commit** `public/` directory (generated files)
- **Never commit** `.terraform/` directory
- **Never commit** `terraform.tfvars` (may contain secrets)
- **Do commit** `.terraform.lock.hcl` (dependency lock file)
- **Be careful with** `casa4-website/themes/shell/` (it's a submodule)

### Reading Files

- **Start with:** `README.md` and `config.toml` for user-facing docs
- **For content:** Check `casa4-website/content/` directory
- **For infrastructure:** Review `main.tf` and `variables.tf`
- **For deployment:** Check `.github/workflows/deploy-all.yml`

### Making Commits

- Use clear, descriptive commit messages
- Test Hugo build locally before committing
- Remember: every push triggers deployment
- Follow branch naming convention: `claude/<branch-name>-<session-id>`

### Security Considerations

- **Never expose** AWS credentials or Terraform tokens
- **Check** that no secrets are in code before committing
- **Verify** S3 bucket policies don't over-expose data
- **Test** Cloudflare page rules to ensure HTTPS enforcement

## Future Improvements / Todo

From project README:
- [ ] Separate staging and production environments
- [ ] Move S3 bucket to eu-west-2 (currently us-east-1)
- [ ] Add Google Analytics integration
- [ ] Add favicon
- [ ] Implement second description section
- [ ] Add additional contact methods (phone/WhatsApp/email)
- [ ] Separate GitHub Actions workflows for different branches

## Key Terminal Theme Features

The site uses a unique terminal/shell aesthetic:

- **Prompt simulation:** `iosif@laptop:~/casa4_files$`
- **Typewriter animation:** Text types out like terminal output
- **Directory tree navigation:** Links displayed as file tree
- **Molokai color scheme:** Dark theme with syntax highlighting colors
- **Command-style interaction:** Navigation feels like shell commands

## Resources & References

- **Hugo Documentation:** https://gohugo.io/documentation/
- **Hugo Shell Theme:** https://github.com/Yukuro/hugo-theme-shell
- **Terraform AWS Provider:** https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- **Terraform Cloudflare Provider:** https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs

## Quick Reference Commands

```bash
# Local development
cd casa4-website && hugo server -w -D

# Build site
cd casa4-website && hugo

# Create new post
cd casa4-website && hugo new posts/my-post.md

# Update git submodules
git submodule update --init --recursive

# Terraform validation
terraform fmt && terraform validate

# Manual deploy (if needed)
./upload-to-s3.sh
```

## Contact & Support

This is a personal project for Casa4 Ltd. For questions about the project structure or implementation, refer to the README.md or examine the code directly.

---

**Last Updated:** 2025-11-18
**Project Status:** Production (live at casa4.co.uk)
**Maintained By:** Iosif
