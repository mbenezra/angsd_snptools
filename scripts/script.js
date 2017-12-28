while(iter.hasNext())
    {
    var ctx= iter.next();
    out.print(ctx.getContig());
    out.print("\t");
    out.print(ctx.getStart());
    for(var i=0;i< ctx.getNSamples();++i)
        {
        out.print("\t");
        var g=ctx.getGenotype(i);
        if(g.isNoCall()) 
            {
            out.print("-");
            }
        else
            {
            var alleles=[];
            for(var k=0;k< g.getAlleles().size();++k)
                {
                alleles.push(g.getAlleles().get(k).getDisplayString());
                }
            alleles.sort();
            out.print(alleles.join("/"));
            }
        }
    out.println();
    }
