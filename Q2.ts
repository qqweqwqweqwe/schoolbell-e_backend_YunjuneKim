function bfs(graph : number[][]) : void {

    let visited : boolean[][] = []
    const move : number[][] = [
        [1,0], [-1,0], [0,1], [0,-1], 
        [1,1], [1,-1], [-1,1], [-1,-1]
    ]

    for (let i = 0; i < graph.length; i++) {
        visited[i] = new Array(graph[i].length).fill(false);
    }
    let answer = 0
    for (let i = 0; i<graph.length; i++){
        for (let j =0; j<graph[0].length; j++){
            if(graph[i][j]==1 && !visited[i][j]){
                const queue : number[][] = []
                queue.push([i,j])
                visited[i][j] = true
                answer+=1
                while(queue.length){
                    const cur = queue.pop()
                    if(!cur){
                        break
                    }
                    const ci : number = cur[0]
                    const cj : number = cur[1]
                    for (const mo of move){
                        const ni : number = ci+mo[0]
                        const nj : number = cj+mo[1]
                        if( 0<=ni && ni<graph.length 
                            && 0<=nj && nj<graph[0].length
                            && !visited[ni][nj] && graph[ni][nj] == 1
                        ){
                            visited[ni][nj] = true
                            queue.push([ni,nj])
                        }
                    }
                }

            }
        }
    }

    console.log("result: " + answer)


}

let testGrpah =[
    [1,0,1,0,0],
    [1,0,0,0,0],
    [1,0,1,0,1],
    [1,0,0,1,0]
]

bfs(testGrpah)  // result: 3