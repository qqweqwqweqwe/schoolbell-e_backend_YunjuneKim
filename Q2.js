function bfs(graph) {
    var visited = [];
    var move = [
        [1, 0], [-1, 0], [0, 1], [0, -1],
        [1, 1], [1, -1], [-1, 1], [-1, -1]
    ];
    for (var i = 0; i < graph.length; i++) {
        visited[i] = new Array(graph[i].length).fill(false);
    }
    var answer = 0;
    for (var i = 0; i < graph.length; i++) {
        for (var j = 0; j < graph[0].length; j++) {
            if (graph[i][j] == 1 && !visited[i][j]) {
                var queue = [];
                queue.push([i, j]);
                visited[i][j] = true;
                answer += 1;
                while (queue.length) {
                    var cur = queue.pop();
                    if (!cur) {
                        break;
                    }
                    var ci = cur[0];
                    var cj = cur[1];
                    for (var _i = 0, move_1 = move; _i < move_1.length; _i++) {
                        var mo = move_1[_i];
                        var ni = ci + mo[0];
                        var nj = cj + mo[1];
                        if (0 <= ni && ni < graph.length
                            && 0 <= nj && nj < graph[0].length
                            && !visited[ni][nj] && graph[ni][nj] == 1) {
                            visited[ni][nj] = true;
                            queue.push([ni, nj]);
                        }
                    }
                }
            }
        }
    }
    console.log("result: " + answer);
}
var testGrpah = [
    [1, 0, 1, 0, 0],
    [1, 0, 0, 0, 0],
    [1, 0, 1, 0, 1],
    [1, 0, 0, 1, 0]
];
bfs(testGrpah);
