# Contributing to CollAction

We welcome any and all contribution. To make contributing easy we have setup this document, describing guidelines that will make your contribution smoother.

- [Filing an issue](#filing-an-issue-or-a-bug)
- [Filing a feature request](#filing-a-feature-request)
- [Branches naming conventions](#branches-naming-conventions)
- [Commit conventions](#commit-conventions)
- [Pull requests](#pull-requests)

# Filing an issue or a bug

We are super stoked if you are ready to file your first issue/bug report! If that is the case, please use the issue template or [click here to file a bug report](https://github.com/CollActionteam/collaction_app/issues/new?assignees=&labels=&template=bug_report.md&title=%5BBUG%5D%3A+Your+issue+title+here).

Before filing an issue, try searching in the issues for keywords related to the issue you are experiencing, there is a chance that someone else already filed the same issue!

It's important when you file an issue, that you try to complete the template as much as possible, this helps with narrowing down the issue, discussing possible solutions, and in the end solving the issue and continuing to build great features!

But fret not, if you somehow have a hard time finding the information requested in the template, we will do our best to help you after you have created the issue. Keep in mind, the most important thing when filing an issue, **is the steps on how to reproduce the bug!**

# Filing a feature request

A feature request is all you need when you have a spark of inspiration. When filing a feature request you do it in the [issues section](https://github.com/CollActionteam/collaction_app/issues), remember to select the feature request template, or [click here to start filing a feature request](https://github.com/CollActionteam/collaction_app/issues/new?assignees=&labels=&template=feature_request.md&title=%5BSUGGESTION%5D%3A+Your+suggestion+title+here).

Describe your idea in as much detail you can, no need to be super technical, but the better your idea is described, the easier its intent is to understand. Sadly it's not easy to guarantee that all features are as relevant, or all features will be implemented, we have to filter them to select the features with the most value. Don't be discouraged if your first feature request is denied, feel free to try another feature.

Before filing a feature request, try searching in the issues for keywords related to the feature request you have in mind, there is a chance that someone else already filed the same or a similar request!

# Branches naming conventions

We use simple naming conventions for branches, to easily navigate and track multiple branches across features. Branches follow a 3 part logic, the first part describes the type of work is being done on the branch.

Often used tags are: `feat`, `feature`, `chore`, `task`, `refac`, `refactor`, `fix`, `bugfix`, `docs`, `documentation`, etc.

The second part is what issue or feature the branch relates to. This is used by taking the issue number, and prefixing it with `gh-`.

Examples: `gh-97`, `gh-104`, etc.

The third and last part describes the scope, it's okay to be generic if the scope is not easily defined. Multiple branches can have a similar name, and thus the scope helps differentiate and specify what exactly the branch pertains to. All words in the scope must be separated by `-`.

<a name="scopes"></a>Examples: `profile-avatar`, `profile-settings`, `auth-new-user`, `crowdaction-details`, etc.

These three parts are separated by a slash (`/`), and concatenating the parts examples for branch names are:
`feat/gh-104/profile-avatar`, `chore/gh-97/update-readme`, etc.

Don't use underscore (`_`) in branch naming, and don't use uppercase letters.

# Commit conventions

To ensure our commit history stays clean, and can more easily be used for tracking, we follow some simple conventions that go hand in hand with our [branches naming conventions](#branches).

The format for the commit title is:
`<tag>(<scope>): <subject>`

The format for a commit with body and footer is:

```
<tag>(<scope>): <subject>
<newline>
<body>
<newline>
<footer>
```

A full example commit:

```
feature(user): add missing user repository method

Motivation: Ability to update the authenticated user was missing

Closes: #117 Relates: #132
```

### Tag

The tag describes the type of work that was actually done in the commit. This can differentiate from the branch name which the commit comes from, in case something changed and the purpose of the commit is not the same as it was intended. Most of the times, the commit tag will be the same as the branch tag.

See [example tags](#tags) from the branch naming conventions section.

### Scope

The scope is not required, in case the scope is specific then it should be added for clarity.

See [example scopes](#scopes) from the branch naming conventions section.

### Subject

The subject should be a short description written in clear, imperative and present tense. Use keywords in present tense such as `update`, `change`, `modify`, etc.

Examples: `update text to fit ui copy`, `hide tabs on profile`, `show onboarding on first app open`, etc.

### Body

Similar to the subject, always use imperative, present tense. The body can be used to present the motivation for the changes in the commit. The body is not a required part, similar to the scope!

### Footer

The footer is used for referencing Github issues, and if the commit is related to one or more specific issues, they should be linked in the footer.

References to issues with Github are made by prefixing the issue number with `#`.

Often used examples: `Relates: #100`, `Closes: #97 Relates: #103`.

If the commit relates to multiple issues, you can repeat the keyword for any amount of times necessary: `Relates: #60 Relates: #69`.

# Pull requests

When your feature is ready to be merged, you can open a pull request to `development`, please do note, we never allow pull requests directly to `master`.

Use your commit title for the PR title as well, if you have multiple small commits on your branch, squash them all into one commit and make sure it follows [our commit conventions](#commits).

Remember to reference any github issues that might be related to your PR, in the PR message!

One rule for when you are done opening your PR:

- Don't tag everyone to review/approve your PR, we keep an eye open on PRs daily, and we might have other priorities. We will get to your PR when time is right.
