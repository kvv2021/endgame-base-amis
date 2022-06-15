---
name: Deploy a new image/AMI
about: Checklist for Curriculum Dev to deploy a new image/AMI.
title: 'Deploy updated NSM Edu Training image - YYYY-MM-DD'
labels: 'image'
assignees: ''

---

# NSM-Edu-Training - Deploy new NSM Student Lab image issue
<!--- Please remove all comments prior to opening the issue with this template --->
<!--- This issue is intended to be used by the Amer-Fed Education Curriculum Dev team to deploy new NSM Student Lab images/AMIs. --->

## Information about updated NSM Student Lab image
<!--- Fill out the applicable items in this section --->

**Name of module(s) being updated:** 

**Name of new or updated file(s):** 

**Link to issue related to changes:** 

### Summary of changes to the NSM Student Lab image
<!--- Write a brief summary regarding the changes being made to the NSM Student Lab image --->

## Deploy to Dev in Strigo

- [ ] Followed steps in _Quickstart_ and _Dev-Guide_ and verified my AMI build passed
- [ ] In your branch, update `course.version` in `ami/group_vars/all.yml` with the latest version number
    - This section of `ami/group_vars/all.yml`:
    ```
    # Course Version
    course:
      version: "7.12.1v2.0"
    ```
- [ ] Add AMI ID to this issue: (include `ami-` in the ID below)
  - AMI ID: `replace-this-with-ami-id`
- [ ] Image deployed to `NSM Operator Dev` Class in Strigo

## Verify NSM Student Lab Functions Properly in NSM Operator Dev event

- [ ] Create new Strigo Event using the `NSM Operator Dev` class
- [ ] Perform operational check using the [`tests.md`](https://github.com/elastic/nsm-edu-training/blob/main/tests.md) file in this repo
- [ ] Copy Test Checklist into **Unit Testing** (within the `<details>`, after `<summary>`) section below
    - This should be performed until the test checklist is migrated to the repo's Pull Request Template file

### Unit Testing Checklist

<details>
<summary>Unit Testing - Click to Expand</summary>

<!--- Paste Test Checklist into this section --->

</details>

- [ ] Lab testing has been performed and the checklist is stored in the **Unit Testing** section above

## Peer Review in NSM Operator Dev
- [ ] Peer review of the updated NSM Student Lab image.  A comment on this issue should be made my the person performing the peer review.

## Deploy to Production in Strigo
- [ ] Verify peer review of the updated module
- [ ] Verify AMI ID to be updated in production Strigo NSM Student Lab classes
- [ ] Image deployed to the ***NSM Student Lab*** classes in Strigo:
  - [ ] `Private Threat Hunting with Kibana`
  - [ ] `Private Department of Defense Cyber Operator`
  - [ ] `Private Network Security Monitoring Cyber Operator`
  - [ ] `Private NSM Cyber Operator`
- [ ] Notify Amer-Fed Education team (in Slack) that the class has been updated with a new AMI

## Review and publish GitHub Release
This should only be performed once the updated image/AMI is deployed to the production Strigo

This section needs to be updated
