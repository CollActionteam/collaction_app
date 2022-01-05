/// TODO: Remove all old code related to GraphQL!!!
const placeholder = "#i#";

const queryGetCrowdActions = "{ crowdactions {name description start end } }";
const queryGetFixedCrowdActions =
    "{ crowdactions(take: #i#) {name description start end } }";
