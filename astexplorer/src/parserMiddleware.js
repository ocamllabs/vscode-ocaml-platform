

import { ignoreKeysFilter, locationInformationFilter, functionFilter, emptyKeysFilter, typeKeysFilter } from './core/TreeAdapter.js';

export default function getTreeAdapter(newParser) {
    return {
        type: 'default',
        options: {
            openByDefault: (newParser.opensByDefault || (() => false)).bind(newParser),
            nodeToRange: newParser.nodeToRange.bind(newParser),
            nodeToName: newParser.getNodeName.bind(newParser),
            walkNode: newParser.forEachProperty.bind(newParser),
            filters: [
                ignoreKeysFilter(newParser._ignoredProperties),
                functionFilter(),
                emptyKeysFilter(),
                locationInformationFilter(newParser.locationProps),
                typeKeysFilter(newParser.typeProps),
            ],
            locationProps: newParser.locationProps,
        },
    };
}