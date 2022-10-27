# casa4

Simple repository for online website [casa4.co.uk](https://casa4.co.uk)

## Installation and running

```bash
cd casa4-website && hugo server -w -D
```

## Concept
- [x] Build a simple website using HUGO
- [x] Built the infrastructure with Terraform
- [x] Use AWS S3 for static file hosting
- [x] Use Cloudflare's DNS
- [ ] Create a full CI/CD Pipeline using Github Actions
- [x] Easily update website content with online editors like [Prose](https://prose.io/)
- [ ] Create a production and a staging environment
- [ ] Add tracking with Google
- [ ] Add favico
- [x] Add actual content on the site
  - [ ] second description
  - [ ] second link section for contact: phone/whatsapp/email

## Todo
- [ ] - move bucket to eu-west-2
- [ ] - separate push actions for the main branches (main, staging, development)

### Resources used to learn 
- [Terraform Youtube Video from DevOps Directive](https://www.youtube.com/watch?v=7xngnjfIlK4)
- [Terraform Cloudflare Example](https://learn.hashicorp.com/tutorials/terraform/cloudflare-static-website?in=terraform/aws#create-a-scoped-cloudflare-api-token)
- [Terraform Cloudflare Example Github Repo](https://github.com/hashicorp/learn-terraform-cloudflare-static-website)
- [Github Actions Documentation - Quickstart](https://docs.github.com/en/actions/quickstart)
- [This video](https://www.youtube.com/watch?v=Sxxw3qtb3_g) that convinced me to use HUGO for static site generation
- [Shell, used Hugo Theme - Official Link](https://themes.gohugo.io/themes/hugo-theme-shell/)
- [Shell, used Hugo Theme - Github Link](https://github.com/Yukuro/hugo-theme-shell/blob/master/docs/customize_terminal/customize_terminal.md)

### Development friendly links for myself
- [Prose editor](https://prose.io/#iosifv/casa4/tree/main/casa4-website/content)
- [Terraform project](https://app.terraform.io/app/iosifv/workspaces/casa4)
- [Cloudflare dashboard](https://dash.cloudflare.com/17c4229eaf5c7c27e34b7527cbb683ec/casa4.co.uk/dns)
- [AWS S3 Bucket](https://s3.console.aws.amazon.com/s3/buckets/casa4.co.uk?region=us-east-1&tab=objects#)

.

#### _Fun fact!_
Mostly built this while in vacation in Cyprus 🇨🇾 at [BEON1X](https://beon1x.com/) music festival.