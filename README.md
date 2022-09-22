# casa4

Configuration for casa4 website should contain
- terraform files
- some kind of static website generator
- github actions


aws s3 cp website/ s3://$(terraform output -raw website_bucket_name)/ --recursive