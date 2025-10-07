# create gh-pages branch

``` bash
git checkout --orphan gh-pages
git reset --hard # make sure all changes are committed before running this!
git commit --allow-empty -m "Initialising gh-pages branch"
git push origin gh-pages
```

Publish via: `quarto publish gh-pages`



To reproduce this manuscript execute `quarto render` in the root of this repository. Open the rendered website at `_manuscript/index.html`
