# PrairieLearn Development Guidance

Jumping into the PrairieLearn system can be a bit overwhelming to say the least, so this page is meant to help you get started. This page is meant to be a walkthrough of the system from the perspective of our Capstone Project discoveries, rather than a comprehensive guide. For more information, please refer to the [PrairieLearn Documentation](https://prairielearn.readthedocs.io/en/latest/).

## Overview/Discoveries

### 🍃 General Workflow

The first thing you'll need is to get the system up and running. To get everything [running locally](https://github.com/PrairieLearn/PrairieLearn/blob/master/docs/installingLocal.md) you'll need Docker Desktop, then, follow these steps:

1. `git clone https://github.com/PrairieLearn/PrairieLearn.git` (or if you want to work on PrairieLearn Ranked, clone the **forked** version of the repository)
2. `docker run -it --rm -p 3000:3000 -w /PrairieLearn -v /path/to/PrairieLearn:/PrairieLearn prairielearn/prairielearn /bin/bash`
   - The path `/path/to/PrairieLearn` above should be replaced with the absolute path to the PrairieLearn source on your computer. If you're in the root of the source directory already, you can substitute `%cd%` (on Windows command prompt outside WSL), `${PWD}` (on Windows PowerShell), or `$PWD` (Linux, MacOS, and WSL) for /path/to/PrairieLearn.
3. `make deps`
4. `make dev` (or `make start` if you're running it in production mode)

> NOTE: On Apple Silicon, step 2 is done differently through emulation: `docker run --platform linux/x86_64 -it --rm -p 3000:3000 -w /PrairieLearn -v $PWD:/PrairieLearn prairielearn/prairielearn /bin/bash`

The process of doing `make deps` and `make dev` every time is incredibly tedious, but will need to be re-done anytime there's a significant change (such as a new migration). Otherwise, any changes to EJS or HTML files will be reflected immediately, and [nodemon](https://nodemon.io/) will automatically restart the server when it detects other changes.

### 📃 Page Structure

When we first began working on the project, we were searching for a "views" or a "models" folder, as is typical in most node.js projects. However, PrairieLearn uses a different structure:

- Every subfolder in the "pages" folder is a different page containing (typically) the following 3 file types:
  - An **EJS** file, which is essentially HTML with some extra features, such as the ability to use variables and functions from the JS file.
  - A **JS** file, which contains the routing for the page, and any other functions to grab information from the SQL file.
  - An **SQL** file, which contains the queries for the page. Each separate query is separated by a "`--BLOCK`" comment, followed by the name of the query.

In addition, there is a "partials" subfolder which contains modularized EJS files that are used in multiple pages, such as the navbar components, or in PrairieLearn Ranked's case, scoreboards. To summarize, you'll likely want to begin by creating your router endpoints in the JS file, and some functions to grab data from the SQL file. Then, create those queries in the SQL file. Finally, you'll want to create the HTML structure in the EJS file (and make a partial out of any repeated code), and use the functions and variables from the JS file to populate the page.

### 📀 Database Changes

Database changes (such as adding new tables or triggers) are done through [**migrations**](https://github.com/PrairieLearn/PrairieLearn/blob/master/apps/prairielearn/src/migrations/README.md). 

1. Enter the `migrations` folder
2. Make a new SQL file with the following naming conventions (`timestamp_name.sql`):
   1. The file name should start with the current timestamp (to get current timestamp, run this command: `node -e "console.log(new Date().toISOString().replace(/\D/g,'').slice(0,14))"`)
   2. An underscore
   3. A small name/description of the migration

### 💩 Bullsh*t

Whenever you try to make a GET or POST request to a page, you'll need to include a CSRF token. Check out [the documentation here](https://prairielearn.readthedocs.io/en/latest/dev-guide/#state-modifying-post-requests). The CSRF token uses the [original URL of the page](https://github.com/PrairieLearn/PrairieLearn/blob/a46bea8bcc7c5f63ce01e77e1a40056034aebefc/apps/prairielearn/src/middlewares/csrfToken.js#L11), so you need to make sure the URL of your request, and the URL of your route both match.

The structure of their database is so incredibly complex; you're better off making your own tables and using triggers to repopulate them — this is the path we went down. Either that, or make a bunch of foreign keys, but that adds a higher level of coupling.

Even though there's a bunch of documentation, it's out of date. I would highly recommend interacting directly with the developers through the links below.

Good luck in `server.js`. It's a mess.

---

## Extra Links
- [Contributing Page](https://github.com/PrairieLearn/PrairieLearn/blob/master/CONTRIBUTING.md)
  - This page describes the process of contributing to the existing PrairieLearn infrastructure, including setup, development, and opening pull requests. Our project worked on a forked version of the repository for use by UBC, rather than having the intention of contributing to the main PrairieLearn repository.
- [PrairieLearn Slack](https://prairielearn.slack.com/join/shared_invite/zt-13kx0hg6v-uuC3kyt_3iBxjSpyhCbYVw#/shared-invite/email)
  - The PrairieLearn Slack is a great place to ask questions and get help from the PrairieLearn developers, mostly in the "pl_help" or "pl_dev" channels. They can sometimes be a little cryptic, but they normally respond quite quickly.
- [GitHub Discussions](https://github.com/PrairieLearn/PrairieLearn/discussions)
  - The GitHub Discussions page is useful for getting more formalized answers to questions, and directly linking them as issues. However, the developers seem to prefer Slack for most questions.
- [Zoom](https://illinois.zoom.us/j/97570655417?pwd=SnByVzFaUXVlb1BIcjhZRHhEQ05Ldz09#success)
  - When you're truly desperate, PrairieLearn office hours are hosted from 12:00-1:00pm on Thursdays.
