# Metrics Dashboards and equivalent

This is some **very rough** Terraform code to do some of the exercises of the _Fundamentals of Metrics Monitoring in Splunk Observability Cloud_ course.

This is the result after completing most of the exercises and some of the optional exercise, building as we go.

## Before you start

The provider documentation with examples is at: https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs

It lists all the options and gives simple examples

## How to use it

You need to set some environment variables in `env.sh`
The instructor will give you `SFX_API_URL`. Find the token in the Portal via

Setting -> Users -> \<your user> -> Show User API Access Token

Then you need to get these into your shell using

```bash
. ./.env.sh
```

At this point you *should* be able to do:

```bash
terraform init
terraform plan
# etc
```

## Using this during the course

Suggest you do

```bash
mv dashboard_groups.tf dashboard_groups.tf-SAVE
mv dashboards.tf dashboards.tf-SAVE
mv detectors.tf detectors.tf-SAVE
```
Note, as far as I can tell, when you create just the dashboard group, it won't be listed in Portal until it contains a dashboard, and similarly a dashboard won't "exist" until it contains a chart/panel. Adding a text panel saying "Hello World" and your name and the date should close this loop.

## Devising panels

My approach is as follows:

- Create the panel by hand, getting the required result
- Show and copy the signalflow definition
- Paste this into an empty block **for the right chart type**
  - The selector "chart type" creates a different type of panel, and the TF resource type is different
- Run `terraform apply` to create the panel
- Adjust the panel on the portal
- Run `terraform plan` to see what you changed
- Update your code and rerun `terraform apply`

## What doesn't work

One of the exercises involves cloning a built-in dashboard to your DB group. This action

- Cannot be easily replicated in Terraform (it's based on someone elses dashboard)
- Places the cloned dashboard into your dashboard group
- If you run `terraform destroy; terraform apply` the recreated dashboard group won't contain this cloned dashboard


