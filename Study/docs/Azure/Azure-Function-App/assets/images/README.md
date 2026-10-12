# Images

Store screenshots and raster images for Azure Function App notes in this folder.

## Conventions

- Use lowercase, hyphenated names: `portal-identity-blade.png`.
- Prefer PNG for screenshots and SVG for vector graphics.
- Remove tenant names, subscription IDs, resource names and any personal data before committing a screenshot.
- Keep images under roughly 500 KB.

## Referencing an image from a note

Notes live one folder below `Azure-Function-App/`, so use `../assets/images/`:

```markdown
![Identity blade in the portal](../assets/images/portal-identity-blade.png)
```

> ⚠️ Always use relative paths. Absolute local paths such as `C:\Users\...` break on other machines, in the website and in PDF builds.

---

[Back to Azure Function App](../../index.md)
