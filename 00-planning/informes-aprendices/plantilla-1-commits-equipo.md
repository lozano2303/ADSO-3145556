# Informe 1 — Commits en el repositorio de documentación y en los repositorios de tu equipo

**Periodo:** del 11 de agosto al 30 de septiembre de 2026 (hora Colombia, UTC-5)
**Repositorio principal de la ficha:** https://github.com/code-sena/ADSO-3145556

| Campo | Valor |
|---|---|
| Aprendiz | Cristofer David Lozano Contreras |
| Usuario de GitHub | lozano2303 |
| Ficha | ADSO-3145556 |
| Proyecto (equipo) | Tu Evento |
| Prefijo de los repositorios del equipo | yev- |
| Correo(s) con el que haces commit | cristoferlozano233@gmail.com |
| Fecha de elaboración | 6 de octubre de 2026 |

<details>
<summary><strong>Instrucciones — léelas y borra este bloque antes de entregar</strong></summary>

**Qué reporta este informe.** Todos los commits que hiciste en el repositorio de documentación (`-docs`) y en los demás repositorios de **tu equipo**. Los commits en cualquier otro repositorio (personal, forks, otros equipos) van en el Informe 2.

**Importante: los repositorios de equipo se crearon el 25 de agosto de 2026.** Antes de esa fecha no pudiste hacer commits en ellos. Si tu trabajo de la primera y segunda semana de agosto estaba en otro repositorio, va en el Informe 2, no aquí.

**Repositorios de cada equipo** (todos en la organización `code-sena`):

| Proyecto | Prefijo | Repositorios |
|---|---|---|
| edu-air-control | `ea-control-` | api, db, docs, portal, **worker** |
| energy-monitor | `en-monitor-` | api, app, db, docs, portal |
| faceattend-edu | `fae-` | api, app, db, docs, portal |
| rent-car | `rtm-` | api, app, db, docs, portal |
| save-your-water | `sy-water-` | api, app, db, docs, **worker** |
| school-guardian | `sg-` | api, app, db, docs, portal |
| translates-sign-language | `trans-sl-` | api, app, db, docs, portal |
| vehicle-washing | `vehicle-w-` | api, app, db, docs, portal |
| woman-alert | `wal-` | api, app, db, docs, portal |
| your-event | `yev-` | api, app, db, docs, portal |

Si tu equipo usa `worker` en lugar de `app` o `portal`, cambia el nombre del bloque correspondiente (sección 3).

**Cómo obtener tus commits.** Para cada repositorio, desde una terminal **Git Bash**, dentro de tu clon del repositorio:

```bash
# Ajusta solo estas tres líneas
AUTOR="tu-correo@ejemplo.com"                 # varios correos: "uno@x.com\|otro@y.com"
DESDE="2026-08-01T00:00:00-05:00"
HASTA="2026-08-30T23:59:59-05:00"

URL=$(git remote get-url origin | sed -E 's#^git@github.com:#https://github.com/#; s#\.git$##')
git fetch --all --prune -q
git log --all --no-merges --author="$AUTOR" --since="$DESDE" --until="$HASTA" \
  --date=iso --reverse \
  --pretty=tformat:"| [%h]($URL/commit/%h) | %ad | %s |" | tee commits.md | wc -l
```

- Se imprime **el total de commits**. Las filas ya vienen en formato de tabla y quedan en el archivo `commits.md`: ábrelo, copia las filas y pégalas en la tabla del repositorio. Luego borra `commits.md`.
- `--all` incluye **todas las ramas**, no solo `main`. Un commit que esté en varias ramas se cuenta una sola vez.
- `--no-merges` deja por fuera los commits de fusión (*Merge pull request…*).
- Si el mensaje de un commit contiene el carácter `|`, reemplázalo por `/` para no romper la tabla.
- Si no tienes el repositorio clonado: `git clone https://github.com/code-sena/PREFIJO-docs`.
- Si un repositorio no tiene commits tuyos en el periodo, **déjalo en la tabla con 0**; no lo borres.

**Qué cuenta como commit tuyo.** Solo los hechos con tu cuenta. Abre un commit en GitHub: si aparece tu foto de perfil, está vinculado. Si no aparece, tu correo de `git config user.email` no está vinculado a tu cuenta: anótalo en *Observaciones*, no lo ocultes.

</details>

## 1. Resumen

| Repositorio | Enlace | Commits |
|---|---|---|
| `yev-docs` | https://github.com/code-sena/yev-docs | 7 |
| `yev-api` | https://github.com/code-sena/yev-api | N/A* |
| `yev-app` | https://github.com/code-sena/yev-app | N/A* |
| `yev-db` | https://github.com/code-sena/yev-db | N/A* |
| `yev-portal` | https://github.com/code-sena/yev-portal | N/A* |
| **Total** | | **7** |

*\*Repositorios aún no creados - el equipo trabaja actualmente en monorepo*

## 2. Repositorio de documentación

- **Repositorio:** `yev-docs`
- **Enlace:** https://github.com/code-sena/yev-docs
- **Total de commits en el periodo:** 7
- **Qué hice (2 a 3 líneas):** Desarrollé la documentación técnica completa del proyecto "Tu Evento", incluyendo la estructura de gobernanza SDD, modelo de dominio DDD, documentación de requerimientos, arquitectura integral, contratos de API y modelo de datos con detalles técnicos comprehensivos.

| Commit ID | Fecha y hora | Mensaje |
|---|---|---|
| [bcc539d](https://github.com/code-sena/yev-docs/commit/bcc539d) | 2026-09-08 14:43:54 -0500 | docs(governance): add SDD governance structure |
| [e33503a](https://github.com/code-sena/yev-docs/commit/e33503a) | 2026-09-08 15:08:07 -0500 | docs(domain): add complete DDD domain model |
| [d28a128](https://github.com/code-sena/yev-docs/commit/d28a128) | 2026-09-08 16:04:05 -0500 | feat(requirements): add complete requirements evidence documentation |
| [da09c53](https://github.com/code-sena/yev-docs/commit/da09c53) | 2026-09-08 16:27:13 -0500 | feat(architecture): complete architecture section with comprehensive evidence |
| [e5c2f20](https://github.com/code-sena/yev-docs/commit/e5c2f20) | 2026-09-08 17:22:16 -0500 | feat(api): complete API contracts documentation |
| [f984dfe](https://github.com/code-sena/yev-docs/commit/f984dfe) | 2026-09-22 14:51:33 -0500 | refactor: reorganize SDD sections from evidence to root structure |
| [7e2195b](https://github.com/code-sena/yev-docs/commit/7e2195b) | 2026-09-22 15:07:28 -0500 | feat(06-data): expand data model documentation with comprehensive technical details |

## 3. Repositorios del equipo

### 3.1 `yev-api`

- **Enlace:** https://github.com/code-sena/yev-api
- **Total de commits en el periodo:** N/A (repositorio no creado)
- **Qué hice (2 a 3 líneas):** Repositorio aún no migrado desde el monorepo principal del equipo.

| Commit ID | Fecha y hora | Mensaje |
|---|---|---|
| N/A | N/A | Repositorio no creado |

### 3.2 `yev-app`

- **Enlace:** https://github.com/code-sena/yev-app
- **Total de commits en el periodo:** N/A (repositorio no creado)
- **Qué hice (2 a 3 líneas):** Repositorio aún no migrado desde el monorepo principal del equipo.

| Commit ID | Fecha y hora | Mensaje |
|---|---|---|
| N/A | N/A | Repositorio no creado |

### 3.3 `yev-db`

- **Enlace:** https://github.com/code-sena/yev-db
- **Total de commits en el periodo:** N/A (repositorio no creado)
- **Qué hice (2 a 3 líneas):** Repositorio aún no migrado desde el monorepo principal del equipo.

| Commit ID | Fecha y hora | Mensaje |
|---|---|---|
| N/A | N/A | Repositorio no creado |

### 3.4 `yev-portal`

- **Enlace:** https://github.com/code-sena/yev-portal
- **Total de commits en el periodo:** N/A (repositorio no creado)
- **Qué hice (2 a 3 líneas):** Repositorio aún no migrado desde el monorepo principal del equipo.

| Commit ID | Fecha y hora | Mensaje |
|---|---|---|
| N/A | N/A | Repositorio no creado |

## 4. Verificación del aprendiz

- [ ] Todos los commits listados los hice con mi cuenta (aparece mi foto de perfil en GitHub).
- [ ] Incluí los commits de **todas las ramas**, no solo de `main`.
- [ ] Todos los commits caen entre el 11 de agosto y el 30 de septiembre de 2026 (hora Colombia).
- [ ] Cada enlace de commit abre en GitHub.
- [ ] Los repositorios en los que no tengo commits quedaron en la tabla con 0.
- [ ] El total de cada repositorio coincide con el número de filas de su tabla.

## 5. Observaciones

El equipo "Tu Evento" actualmente trabaja en un monorepo y solo tiene creado el repositorio `yev-docs`. Los repositorios `yev-api`, `yev-app`, `yev-db` y `yev-portal` aún no han sido creados ni migrados desde el monorepo principal.

Todos mis commits (7 en total) se realizaron en septiembre de 2026, específicamente el 8 de septiembre (5 commits) y el 22 de septiembre (2 commits), todos dentro del período del informe (11 de agosto - 30 de septiembre de 2026).

El trabajo se enfocó en la documentación técnica completa del proyecto, estableciendo las bases arquitecturales y de diseño necesarias para el desarrollo posterior. Todos los commits están correctamente vinculados a mi cuenta de GitHub (lozano2303) y fueron realizados con el correo cristoferlozano233@gmail.com.

---

*Declaro que la información de este informe es veraz y que los commits listados son de mi autoría.*

**Aprendiz:** Cristofer David Lozano Contreras **Fecha:** 6 de octubre de 2026
