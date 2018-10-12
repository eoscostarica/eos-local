#  EOS dApp Boilerplate

EOS React.js based dApp frontend.

## Code Standards

We use [standardjs code style](https://standardjs.com) and we favor [functional javascript programming](https://www.youtube.com/watch?v=BMUiFMZr7vk&list=PL0zVEGEvSaeEd9hlmCXrk5yUyqUag-n84) and declarative code style.

## Directory Structure

```
.
├── docs/ .............................................. documentation files and media
├── public/ ............................................ static and public files
├── src/ ............................................... application source code
|     |── components/ .................................. shared components ( mostly stateless )
|     |── config/ ...................................... component configuration files 
|     |── language/ .................................... i18n translations 
|     |── models/ ...................................... rematch models 
|     |── routes/ ...................................... route components
|     |── services/ .................................... singleton services ( vanillajs )
|     |── utils/ ....................................... utilities folder ( vanillajs )
|     |── app.js ....................................... main app container
|     |── serviceWorker.js ............................. cra service worker
|     └── index.js ..................................... app bootstrapper
├── .eslintrc .......................................... code style rules
├── package.json ....................................... dependencies manifest
├── config-overrides.js ................................ configuration overrides for `create-react-app`
├── .env ............................................... environment variables (for local development)
├── .node-version ...................................... node version file for AVN
├── .eslintrc .......................................... code style rules
├── package.json ....................................... dependencies manifest
└── config-overrides.js ................................ configuration overrides for `create-react-app`

```

## React Community Components 

This is a list of the most react community components included in this boilerplate.

- [react-app-rewired](https://github.com/timarney/react-app-rewired) for tweaking `create-react-app` configuration without ejecting
- [reach-router](https://github.com/reach/router) for a more accessible router.
- [rematch](https://github.com/rematch/rematch) to use `redux` best practices without all the boilerplate.
- [apollo-client](https://github.com/apollographql/apollo-client) react apollo client with `apollo-boost`.
- [material-ui](https://github.com/mui-org/material-ui) components that implement Google's Material Design.

## Start Up

1. `$ yarn`
2. `$ yarn start`

This will launch your browser or you can navigate directly to `http://localhost:3000/` to use dmeetup.

## Continuous Integration Process

We follow a continuous integration process based on Github flow that leverages the following tools:

- [TravisCI](https://travis-ci.org/) to run test and code style checks
- [Netlify](https://netlify.com) for continuous delivery to the stanging server and creation pull request specific environments for testing. awesome!
- [Code Factor](https://codefactor.io) for automated code quality reviews.

