const placeHolder = "#i#";

const getCrowdActionsQuery = "{ crowdactions {name description start end } }";
const getFixedCrowdActionsQuery =
    "{ crowdactions(take: #i#) {name description start end } }";
