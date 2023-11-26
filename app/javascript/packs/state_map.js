const d3 = require('d3');
const stateMapUtils = require('./state_map_utils');
require('../stylesheets/map.scss');

document.addEventListener('DOMContentLoaded', () => {
    const stateMap = new stateMapUtils.Map();

    d3.json(stateMap.topojsonUrl).then((topology) => {
        const mapAssets = stateMapUtils.parseTopojson(stateMap, topology);

        stateMap.svgElement
            .selectAll('path')
            .data(mapAssets.geojson.features)
            .enter()
            .append('path')
            .attr('class', 'actionmap-view-region')
            .attr('d', mapAssets.path)
            .attr('data-county-name', (d) => stateMap.counties[d.properties.COUNTYFP].name)
            .attr('data-county-fips-code', (d) => d.properties.COUNTYFP);

        stateMapUtils.setupEventHandlers(stateMap);
    });

    const countyLinks = document.querySelectorAll('.county-link');

    countyLinks.forEach((link) => {
        link.addEventListener('click', (event) => {
            event.preventDefault();
            const stateSymbol = link.getAttribute('data-state-symbol');
            const countyFIPSCode = link.getAttribute('data-county-fips-code');
            const searchURL = `/search?state_symbol=${stateSymbol}&county_fips_code=${countyFIPSCode}`;
            window.location.href = searchURL;
        });
    });
});
