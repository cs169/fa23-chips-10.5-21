const d3 = require('d3');
const stateMapUtils = require('./state_map_utils');

require('../stylesheets/map.scss');

$(document).ready(() => {
    const stateMap = new stateMapUtils.Map();
    d3.json(stateMap.topojsonUrl).then((topology) => {
        const mapAssets = stateMapUtils.parseTopojson(stateMap, topology);
        stateMap.svgElement.selectAll('path')
            .data(mapAssets.geojson.features)
            .enter()
            .append('path')
            .attr('class', 'actionmap-view-region')
            .attr('d', mapAssets.path)
            .attr('data-county-name', (d) => stateMap.counties[d.properties.COUNTYFP].name)
            .attr('data-county-fips-code', (d) => d.properties.COUNTYFP);

        stateMapUtils.setupEventHandlers(stateMap);
    });
});

document.addEventListener("DOMContentLoaded", function() {
  var countyLinks = document.querySelectorAll(".county-link");

  countyLinks.forEach(function(link) {
    link.addEventListener("click", function(event) {
      event.preventDefault();
      var stateSymbol = link.getAttribute("data-state-symbol");
      var countyFIPSCode = link.getAttribute("data-county-fips-code");
      var searchURL = "/search?state_symbol=" + stateSymbol + "&county_fips_code=" + countyFIPSCode;
      window.location.href = searchURL;
    });
  });
});
