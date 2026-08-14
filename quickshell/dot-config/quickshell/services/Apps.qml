pragma Singleton

import QtQuick
import Quickshell

// Desktop entry search for the launcher.
Singleton {
    id: root

    readonly property var all: {
        const out = [];
        for (const e of (DesktopEntries.applications?.values ?? []))
            if (!e.noDisplay)
                out.push(e);
        out.sort((a, b) => a.name.localeCompare(b.name));
        return out;
    }

    // Subsequence match: every character of `needle` appears in `haystack` in
    // order. Cheap, and it is what makes "ff" find "Firefox".
    function subsequence(haystack: string, needle: string): bool {
        let i = 0;
        for (let j = 0; j < haystack.length && i < needle.length; j++)
            if (haystack[j] === needle[i])
                i++;
        return i === needle.length;
    }

    // Higher is better; -1 means no match.
    function score(entry, query: string): int {
        if (!query)
            return 0;

        const q = query.toLowerCase();
        const name = (entry.name ?? "").toLowerCase();

        if (name === q)
            return 1000;
        if (name.startsWith(q))
            return 900 - name.length;
        const wordStart = name.split(/[\s-_]+/).some(w => w.startsWith(q));
        if (wordStart)
            return 800 - name.length;
        if (name.includes(q))
            return 700 - name.length;

        const generic = (entry.genericName ?? "").toLowerCase();
        if (generic.includes(q))
            return 500;

        const keywords = (entry.keywords ?? "").toString().toLowerCase();
        if (keywords.includes(q))
            return 400;

        const comment = (entry.comment ?? "").toLowerCase();
        if (comment.includes(q))
            return 300;

        // Fall back to a fuzzy match on the name so typos still land.
        if (subsequence(name, q))
            return 100;

        return -1;
    }

    function search(query: string, limit: int): var {
        const scored = [];
        for (const e of all) {
            const s = score(e, query);
            if (s >= 0)
                scored.push({
                    entry: e,
                    score: s
                });
        }
        scored.sort((a, b) => b.score - a.score || a.entry.name.localeCompare(b.entry.name));
        return scored.slice(0, limit).map(x => x.entry);
    }
}
