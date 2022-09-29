# casa4

Configuration for casa4 website should contain
- terraform files
- some kind of static website generator
- github actions

Followed these:
- https://learn.hashicorp.com/tutorials/terraform/cloudflare-static-website?in=terraform/aws#create-a-scoped-cloudflare-api-token
- https://github.com/hashicorp/learn-terraform-cloudflare-static-website

Account links:
- https://app.terraform.io/app/iosifv/workspaces/casa4
- https://dash.cloudflare.com/17c4229eaf5c7c27e34b7527cbb683ec/casa4.co.uk/dns
- https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fs3.console.aws.amazon.com%2Fs3%2Fbuckets%2Fcasa4.co.uk%3Fregion%3Dus-east-1%26state%3DhashArgs%2523%26tab%3Dobjects%26isauthcode%3Dtrue&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fs3&forceMobileApp=0&code_challenge=ipjw9m4PWHPApVNMRL-pu6biENaqjAYajUzqf2y55uU&code_challenge_method=SHA-256

Quick commands:
- aws s3 cp website/ s3://$(terraform output -raw website_bucket_name)/ --recursive