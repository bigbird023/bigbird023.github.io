# bigbird023.github.io
My Tech Website

## Publish as GitHub Pages

This repository is prepared for GitHub Pages. To publish the site:

1. Go to the repository Settings -> Pages and select the `main` branch and `/ (root)` or `/docs` folder as the publishing source.
2. Optionally choose a custom domain or use the default `github.io` domain.
3. If you want to use Jekyll layouts provided here, ensure there is no conflicting `_config.yml` in the repo. Add one to set site title and author if desired.

Example minimal `_config.yml` to add at repo root:

```yaml
title: "My IT Knowledge Site"
author: "Your Name"
```

## Next steps

- Fill the files in `it-knowledge/` with the full, transcribed content from the PDF.
- Add images and code samples into the same directory and reference them from the Markdown.
- Consider running a local preview with `bundle exec jekyll serve` (if using Ruby Jekyll) or use GitHub's automatic build.

## Helper scripts for PDF → site

I added two helper scripts in `scripts/` to help convert the PDF into per-page Markdown and generate site pages:

- `scripts/convert_pdf.sh`: Uses `pdftotext` to split the PDF into per-page text files and suggests using `pandoc` to clean to Markdown. Requires `poppler-utils` (for `pdftotext`) and optionally `pandoc`.
- `scripts/generate_pages.py`: Reads the `page-*` text/markdown files and heuristically creates folders and `index.md` or numbered `.md` files with Jekyll front matter.

Typical local workflow:

1. Put the PDF on the local machine, e.g. `IT Knowledge.pdf`.
2. Run the converter to extract pages: `./scripts/convert_pdf.sh "IT Knowledge.pdf" tmp/pages`
3. Optionally convert extracted text files to Markdown with `pandoc`:

```bash
for f in tmp/pages/*; do
  pandoc -f plain -t gfm -o "${f%.*}.md" "$f"
done
```

4. Generate site pages from the per-page markdown:

```bash
python3 scripts/generate_pages.py tmp/pages site/it-knowledge
```

5. Review the created files in `site/it-knowledge` and move or edit them into `it-knowledge/` in this repo.

If you'd like, I can run these steps here now that the PDF is present in the repo. I will:

- run `scripts/convert_pdf.sh` to split the PDF into per-page text files,
- optionally run `pandoc` to convert them to Markdown,
- run `scripts/generate_pages.py` to produce folders and `index.md` files,
- iterate on the generated pages to clean up headings, add examples and tweak structure,
- commit the new files into the repo and report the results.

To proceed, reply with "Please run the pipeline" and I will execute the steps and create a commit containing the generated pages.

