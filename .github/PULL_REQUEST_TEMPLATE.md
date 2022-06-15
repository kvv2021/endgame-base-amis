# NSM-Edu-Training - Pull Request

## Impacted module(s)

<!--- Please place an x between the brackets for the impacted module(s) then delete options that are not relevant. --->
- [ ] Kibana for Operators
- [ ] Kibana for Operators 2
- [ ] Linux 1
- [ ] Linux 2
- [ ] NSM Team Hunt
- [ ] NSM Individual Hunt
- [ ] Packet Analysis
- [ ] Protocol Analysis
- [ ] IDS with Suricata
- [ ] Zeek 1
- [ ] Zeek 2

## What is the related issue?
<!--- Add links to any related issues in this section --->
**Link to related issue(s)**: 

## Proposed Changes

<!--- Describe the big picture of your changes here to communicate to the maintainers why we should accept this pull request. If it fixes a bug or resolves a feature request, be sure to link to that issue. --->


## Pull request type
<!-- Please try to limit your pull request to one type, submit multiple pull requests if needed. --> 

<!--- Add an x to the relevant pull request type then delete options that are not relevant. --->
What types of changes does your code introduce?
_Put an `x` in the boxes that apply_
- [ ] Bugfix
- [ ] Feature
- [ ] Code style update (formatting, renaming)
- [ ] Refactoring (no functional changes, no api changes)
- [ ] Build related changes
- [ ] Documentation Update
  - [ ] GitHub Repo Documentation (`.md` files)
  - [ ] Other Documentation
- [ ] Other (please describe): 


## What is the current behavior?
<!-- Please describe the current behavior that you are modifying. -->

## What is the new behavior?
<!-- Please describe the behavior or changes that are being added by this PR. -->

-
-
-

## Does this introduce a breaking change?
<!--- Please place an x between the brackets for the breaking change response then delete option that is not relevant. --->
- [ ] Yes
- [ ] No

<!-- If this introduces a breaking change, please describe the impact and migration path for existing applications below. -->


## Other information

<!-- Any other information that is important to this PR such as screenshots of how the component looks before and after the change. -->

## Pull request checklist

Please check if your PR fulfills the following requirements:
- [ ] Tests for the changes have been added (for bug fixes / features)
- [ ] Docs have been reviewed and added / updated if needed (for bug fixes / features)
- [ ] Build was run locally and any changes were pushed
- [ ] I have updated `course.version` in `ami/group_vars/all.yml` with the latest version number
    - Update this section of `ami/group_vars/all.yml`:
    ```
    # Course Version
    course:
      version: "7.12.1v2.0"
    ```
    - **Note**: The `course.version` should be the same as the next [draft release version](https://github.com/elastic/nsm-edu-training/releases)
- [ ] Add the appropriate `version:major` or `version:minor` label to this pull request
    - The label version should correlate with the `course.version` and align with the next [draft release version](https://github.com/elastic/nsm-edu-training/releases)
- [ ] Peer review completed for the following:
    - [ ] Ensure the proper labels are applied
    - [ ] Ensure the `course.version` aligns with the next [draft release version](https://github.com/elastic/nsm-edu-training/releases)

### GitHub Repo Docs Checklist
<!--- Only fill out this section if this PR is for 'GitHub Repo Documentation' --->
<!--- delete this section if it is not relevant --->
- [ ] I have verified that the `.md` files I am changing should only exist in the repo and not be published to the [Team Wiki](https://docs.elastic.dev/afeDocs/home).
- [ ] I have added a note in either the **Proposed Changes** section above or the **Other Information** section below stating the changes being made to the `.md` files in this repo.

