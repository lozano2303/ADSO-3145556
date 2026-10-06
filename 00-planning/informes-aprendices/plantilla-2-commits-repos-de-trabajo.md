# Informe 2 — Commits en los repositorios en los que trabajaste

**Periodo:** del 11 de agosto al 30 de septiembre de 2026 (hora Colombia, UTC-5)
**Repositorio principal de la ficha:** https://github.com/code-sena/ADSO-3145556

| Campo | Valor |
|---|---|
| Aprendiz | Cristofer David Lozano Contreras |
| Usuario de GitHub | lozano2303 |
| Ficha | ADSO-3145556 |
| Proyecto (equipo) | Tu Evento |
| Correo(s) con el que haces commit | cristoferlozano233@gmail.com |
| Fecha de elaboración | 6 de octubre de 2026 |

<details>
<summary><strong>Instrucciones — léelas y borra este bloque antes de entregar</strong></summary>

**Qué reporta este informe.** Todos los commits que hiciste en **los demás repositorios en los que trabajaste**: tu repositorio personal o de perfil, tu fork de `ADSO-3145556`, repositorios de otros equipos, `design-software` y cualquier otro. **No repitas aquí** los repositorios de tu equipo (`-docs`, `-api`, `-app`, `-db`, `-portal`, `-worker`): esos van en el Informe 1.

**Tipos de repositorio** (úsalos en la columna *Tipo*): `Personal` · `Fork de la ficha` · `Otro equipo` · `design-software` · `Otro`.

**Paso 1 — descubre en qué repositorios trabajaste.** Elige una de las dos formas (reemplaza `TU_USUARIO`):

- *Desde el navegador:* abre
  `https://github.com/search?q=author%3ATU_USUARIO+author-date%3A2026-08-01..2026-08-30&type=commits`
  y mira en qué repositorios aparecen tus commits.
- *Desde la terminal* (requiere `gh`, la CLI de GitHub, con sesión iniciada):

```bash
gh search commits --author=TU_USUARIO --author-date=2026-08-01..2026-08-30 --limit 1000 \
  --json repository --jq '.[] | .repository.fullName' | sort | uniq -c
```

Te devuelve cada repositorio con el número de commits que encontró.

> **Advertencia:** la búsqueda de GitHub solo revisa la **rama por defecto** de cada repositorio. Si trabajaste en otra rama (`dev`, `docs`, `feature/…`), esos commits no aparecen. Por eso el Paso 2 es obligatorio, y además debes acordarte de los repositorios donde trabajaste solo en ramas secundarias.
> Los commits de los días 1 y 30 pueden cambiar de lado por la zona horaria: verifícalos con el Paso 2.

**Paso 2 — obtén los commits de cada repositorio.** Para cada repositorio, desde una terminal **Git Bash**, dentro de tu clon:

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

- Se imprime **el total de commits**. Las filas ya vienen en formato de tabla y quedan en `commits.md`: ábrelo, copia las filas y pégalas en la tabla del repositorio. Luego borra `commits.md`.
- `--all` incluye **todas las ramas**. Un commit que esté en varias ramas se cuenta una sola vez.
- `--no-merges` deja por fuera los commits de fusión.
- Si el mensaje de un commit contiene el carácter `|`, reemplázalo por `/` para no romper la tabla.
- El enlace de cada commit funciona con el `URL` del repositorio **desde el que clonaste**. Si clonaste un fork, el enlace apunta a tu fork, que es lo correcto.

**Repositorios privados.** Si un repositorio es privado, indica en *Visibilidad* si el usuario `ariel5253` tiene acceso. Un commit que el instructor no puede abrir no se puede verificar.

**Qué cuenta como commit tuyo.** Solo los hechos con tu cuenta. Abre un commit en GitHub: si aparece tu foto de perfil, está vinculado. Si no aparece, tu correo de `git config user.email` no está vinculado a tu cuenta: anótalo en *Observaciones*, no lo ocultes.

**Copia el bloque de la sección 2 una vez por cada repositorio.** Si en el periodo trabajaste en un solo repositorio, deja un solo bloque.

</details>

## 1. Resumen de repositorios

| # | Repositorio | Enlace | Tipo | Visibilidad | Commits |
|---|---|---|---|---|---|
| 1 | `lozano2303/TuEvento` | https://github.com/lozano2303/TuEvento | Personal | Público | 64 |
| | **Total** | | | | **64** |

## 2. Detalle por repositorio

### 2.1 `lozano2303/TuEvento`

- **Enlace del repositorio:** https://github.com/lozano2303/TuEvento
- **Tipo:** Personal
- **Visibilidad:** Público (¿`ariel5253` tiene acceso? Sí)
- **Total de commits en el periodo:** 64
- **Qué hice (2 a 3 líneas):** Desarrollé el monorepo completo del proyecto "Tu Evento" incluyendo backend Spring Boot, frontend React, aplicación móvil React Native, sistema de asientos en tiempo real con WebSockets, módulos de pagos/tickets/wallet con arquitectura DDD, microservicios de payment gateway, y flujos completos de checkout con integración de múltiples tecnologías.

| Commit ID | Fecha y hora | Mensaje |
|---|---|---|
| [f717c5c](https://github.com/lozano2303/TuEvento/commit/f717c5c) | 2026-08-12 14:13:31 -0500 | fix(modal): stop focus trap from re-running on every keystroke, breaking input focus |
| [9acbfb5](https://github.com/lozano2303/TuEvento/commit/9acbfb5) | 2026-08-12 14:32:33 -0500 | fix(security): add explicit method-level matchers for events/sections/seats endpoints |
| [71e420e](https://github.com/lozano2303/TuEvento/commit/71e420e) | 2026-08-12 14:52:44 -0500 | fix(db): add ON DELETE CASCADE to event_status_log FK, allow deleting DRAFT events with status history |
| [0761c1f](https://github.com/lozano2303/TuEvento/commit/0761c1f) | 2026-08-12 15:49:41 -0500 | fix(db): cascade delete from event to all directly-owned child tables |
| [232a584](https://github.com/lozano2303/TuEvento/commit/232a584) | 2026-08-12 17:29:53 -0500 | feat(auth): add automatic token refresh with 401/403 distinction in backend |
| [be0c830](https://github.com/lozano2303/TuEvento/commit/be0c830) | 2026-08-12 23:26:55 -0500 | feat(auth): centralize logout across app with backend session revocation |
| [169e53d](https://github.com/lozano2303/TuEvento/commit/169e53d) | 2026-08-12 23:50:55 -0500 | feat(auth): migrate all authenticated services to httpClient interceptor |
| [ce88848](https://github.com/lozano2303/TuEvento/commit/ce88848) | 2026-08-13 00:01:06 -0500 | feat(auth): sync logout across browser tabs via storage event |
| [220ea68](https://github.com/lozano2303/TuEvento/commit/220ea68) | 2026-08-13 00:14:40 -0500 | fix(security): protect profile, organizer-petition, and layout editor routes |
| [dc2608a](https://github.com/lozano2303/TuEvento/commit/dc2608a) | 2026-08-13 13:38:01 -0500 | feat(seats): add reservation columns and base WebSocket/STOMP config with JWT handshake auth |
| [d7b8aa0](https://github.com/lozano2303/TuEvento/commit/d7b8aa0) | 2026-08-13 17:22:19 -0500 | refactor(websocket): reduce handshake logging to essentials |
| [ffe9bb2](https://github.com/lozano2303/TuEvento/commit/ffe9bb2) | 2026-08-16 15:23:51 -0500 | feat(seats): add reservation with TTL and WebSocket broadcast on status change |
| [034ad3d](https://github.com/lozano2303/TuEvento/commit/034ad3d) | 2026-08-16 15:32:01 -0500 | feat(seats): auto-generate seat_block/seat records from layout JSON on save |
| [07959aa](https://github.com/lozano2303/TuEvento/commit/07959aa) | 2026-08-16 16:06:30 -0500 | fix(db): align seat status/type check constraints with Java enum casing |
| [51a6d25](https://github.com/lozano2303/TuEvento/commit/51a6d25) | 2026-08-16 16:23:34 -0500 | feat(seats): add SeatService and WebSocket client for real-time seat updates |
| [0ebba55](https://github.com/lozano2303/TuEvento/commit/0ebba55) | 2026-08-16 16:30:55 -0500 | feat(seats): add interactive seat selection view with real-time WebSocket sync |
| [2b27020](https://github.com/lozano2303/TuEvento/commit/2b27020) | 2026-08-16 16:41:17 -0500 | fix(vite): polyfill global as globalThis for sockjs-client compatibility |
| [4fb43ea](https://github.com/lozano2303/TuEvento/commit/4fb43ea) | 2026-08-18 23:05:54 -0500 | feat(seats): integrate seat selector into EventDetail with quantity picker and section filter |
| [7ab336d](https://github.com/lozano2303/TuEvento/commit/7ab336d) | 2026-08-18 23:49:46 -0500 | feat(seats): guided view with auto-fit framing and rebalanced 3-column layout |
| [233fc8f](https://github.com/lozano2303/TuEvento/commit/233fc8f) | 2026-08-19 00:03:17 -0500 | fix(seats): prevent quantity stepper from going below cart size |
| [3f2bf2a](https://github.com/lozano2303/TuEvento/commit/3f2bf2a) | 2026-08-20 16:35:09 -0500 | feat(mobile): restructure tabs — home landing, events tab with role-based content (list/QR) |
| [7c76297](https://github.com/lozano2303/TuEvento/commit/7c76297) | 2026-08-20 17:00:24 -0500 | fix(mobile): resolve localhost host in event cover image URLs |
| [939f68c](https://github.com/lozano2303/TuEvento/commit/939f68c) | 2026-08-21 16:22:46 -0500 | feat(mobile): add EventDetailScreen with event info and media gallery |
| [c8bfaf4](https://github.com/lozano2303/TuEvento/commit/c8bfaf4) | 2026-08-21 17:23:03 -0500 | feat(mobile): add Skia-based seat map canvas |
| [4e39259](https://github.com/lozano2303/TuEvento/commit/4e39259) | 2026-08-25 11:00:56 -0500 | fix(mobile): resolve Reanimated 4 build config + add zoom to SeatMapCanvas |
| [4f610da](https://github.com/lozano2303/TuEvento/commit/4f610da) | 2026-08-25 16:12:48 -0500 | fix(mobile): align expo module versions with expo install --fix |
| [45f8447](https://github.com/lozano2303/TuEvento/commit/45f8447) | 2026-08-26 14:50:05 -0500 | feat(mobile): add seat map canvas with Skia (without zoom/pan) - stable version |
| [7fd3e2c](https://github.com/lozano2303/TuEvento/commit/7fd3e2c) | 2026-08-26 15:22:16 -0500 | feat(mobile): add section navigation with filtered seat map view |
| [82a8f5b](https://github.com/lozano2303/TuEvento/commit/82a8f5b) | 2026-08-26 17:27:30 -0500 | feat: implement real-time seat selection with WebSocket on mobile |
| [03852fd](https://github.com/lozano2303/TuEvento/commit/03852fd) | 2026-08-27 14:22:51 -0500 | fix(mobile): add cart TTL countdown, fix cart not rendering |
| [443c900](https://github.com/lozano2303/TuEvento/commit/443c900) | 2026-08-27 14:31:11 -0500 | fix: hydrate seat quantity stepper from user's existing reservations |
| [92671ba](https://github.com/lozano2303/TuEvento/commit/92671ba) | 2026-08-27 16:34:21 -0500 | feat: instant seat expiration UX (10s scheduler + optimistic client deselection) |
| [cab52e8](https://github.com/lozano2303/TuEvento/commit/cab52e8) | 2026-08-27 16:51:29 -0500 | feat (mobile): add toast notification system base |
| [88341d7](https://github.com/lozano2303/TuEvento/commit/88341d7) | 2026-08-27 17:11:19 -0500 | feat: add toast alert system for seat selection edge cases |
| [f517175](https://github.com/lozano2303/TuEvento/commit/f517175) | 2026-09-01 15:47:36 -0500 | feat: add sub-section navigation with continuous seat numbering |
| [f19848e](https://github.com/lozano2303/TuEvento/commit/f19848e) | 2026-09-01 15:59:47 -0500 | style: restyle warning toasts as theme-aware tips with icon |
| [15820c8](https://github.com/lozano2303/TuEvento/commit/15820c8) | 2026-09-03 15:40:11 -0500 | feat: enforce min touch-friendly seat zoom with row pagination fallback |
| [0859ecc](https://github.com/lozano2303/TuEvento/commit/0859ecc) | 2026-09-03 17:42:49 -0500 | fix(seat-map): add visual margin to 10x10 windowed section view |
| [c9bc876](https://github.com/lozano2303/TuEvento/commit/c9bc876) | 2026-09-05 10:05:11 -0500 | fix(seat-selector): replace cart prop with canSelectMore boolean |
| [e2f2309](https://github.com/lozano2303/TuEvento/commit/e2f2309) | 2026-09-07 17:17:48 -0500 | fix: dynamic row/column pagination for irregular sections |
| [90df241](https://github.com/lozano2303/TuEvento/commit/90df241) | 2026-09-09 14:15:50 -0500 | fix: preserve valid page on the other axis when navigating grid pagination |
| [45e4b0c](https://github.com/lozano2303/TuEvento/commit/45e4b0c) | 2026-09-09 17:42:39 -0500 | fix: use real seat bounding box for per-page framing in polygon sections |
| [556ce89](https://github.com/lozano2303/TuEvento/commit/556ce89) | 2026-09-15 10:34:37 -0500 | fix(mobile/seat-map): fix overview zoom, centering and setState-in-render |
| [f04518b](https://github.com/lozano2303/TuEvento/commit/f04518b) | 2026-09-15 11:46:05 -0500 | feat(mobile/seat-map): implement 10x10 windowed seat view with col/row pagination |
| [baad416](https://github.com/lozano2303/TuEvento/commit/baad416) | 2026-09-15 14:28:47 -0500 | fix(mobile/seat-map): prevent seat cropping with adaptive sizing and web colors |
| [935c9c3](https://github.com/lozano2303/TuEvento/commit/935c9c3) | 2026-09-15 23:18:19 -0500 | fix(mobile): remove isReserving flag to prevent color flicker in seat selection |
| [cb31723](https://github.com/lozano2303/TuEvento/commit/cb31723) | 2026-09-16 00:44:06 -0500 | perf(mobile): implement DOD for 100k+ seats with TypedArrays and batch rendering |
| [281f3d2](https://github.com/lozano2303/TuEvento/commit/281f3d2) | 2026-09-17 17:21:24 -0500 | fix: ios seat picker, google oauth client-id, and missing web dependency |
| [4e2a91c](https://github.com/lozano2303/TuEvento/commit/4e2a91c) | 2026-09-20 14:51:41 -0500 | feat(fake-payment-gateway): add independent payment gateway microservice for local dev |
| [cb87f87](https://github.com/lozano2303/TuEvento/commit/cb87f87) | 2026-09-20 15:44:09 -0500 | feat(ticket): add complete order and ticket management module with DDD architecture |
| [e80cc82](https://github.com/lozano2303/TuEvento/commit/e80cc82) | 2026-09-20 16:16:06 -0500 | feat(payment): implement payment module with fake-gateway integration |
| [a3b4b0b](https://github.com/lozano2303/TuEvento/commit/a3b4b0b) | 2026-09-20 17:19:24 -0500 | feat(payment): implement payment module with fake-gateway integration |
| [fe14909](https://github.com/lozano2303/TuEvento/commit/fe14909) | 2026-09-20 19:35:03 -0500 | fix(payment): resolve payment gateway integration issues |
| [b49d546](https://github.com/lozano2303/TuEvento/commit/b49d546) | 2026-09-21 16:56:15 -0500 | fix(docker): replace mvnw with Maven install and update MinIO registry |
| [c835d12](https://github.com/lozano2303/TuEvento/commit/c835d12) | 2026-09-21 21:06:17 -0500 | fix(payment): align webhook HMAC signature encoding between fake-gateway and backend |
| [ab29589](https://github.com/lozano2303/TuEvento/commit/ab29589) | 2026-09-21 22:58:56 -0500 | fix(ticket,seat): sync seat status with payment outcome |
| [49d1bf4](https://github.com/lozano2303/TuEvento/commit/49d1bf4) | 2026-09-22 09:24:14 -0500 | feat(web/checkout): implement checkout and payment pending flow |
| [e5209e6](https://github.com/lozano2303/TuEvento/commit/e5209e6) | 2026-09-22 10:11:41 -0500 | fix(checkout): handle cancelled payments and improve gateway UI |
| [53ae8c6](https://github.com/lozano2303/TuEvento/commit/53ae8c6) | 2026-09-23 16:56:55 -0500 | feat(mobile): add checkout and payment flow with fake gateway integration |
| [a30c19a](https://github.com/lozano2303/TuEvento/commit/a30c19a) | 2026-09-24 14:22:51 -0500 | feat(payment-refund): implement payment refund flow end-to-end (fake-gateway + backend TuEvento) |
| [305e557](https://github.com/lozano2303/TuEvento/commit/305e557) | 2026-09-24 17:19:32 -0500 | feat(wallet): implement wallet module with checkout integration |
| [b7bf231](https://github.com/lozano2303/TuEvento/commit/b7bf231) | 2026-09-25 19:50:00 -0500 | feat(wallet): complete payment integration with wallet credits |
| [44aa44c](https://github.com/lozano2303/TuEvento/commit/44aa44c) | 2026-09-26 14:39:23 -0500 | feat(wallet): integrate dynamic theming and real backend data in wallet page |
| [bfd1dbb](https://github.com/lozano2303/TuEvento/commit/bfd1dbb) | 2026-09-28 16:11:40 -0500 | feat(notification): implement complete notification module with DDD architecture |
| | | |

## 3. Verificación del aprendiz

- [SI] Todos los commits listados los hice con mi cuenta (aparece mi foto de perfil en GitHub).
- [SI] Incluí los commits de **todas las ramas** de cada repositorio, no solo de la rama por defecto.
- [SI] Todos los commits caen entre el 11 de agosto y el 30 de septiembre de 2026 (hora Colombia).
- [NO] No repetí repositorios del Informe 1 (los de mi equipo).
- [SI] Cada enlace de repositorio y de commit abre en GitHub.
- [SI] El total de cada repositorio coincide con el número de filas de su tabla.
- [N/A] En los repositorios privados indiqué si el instructor tiene acceso.

## 4. Observaciones

Este informe documenta el trabajo realizado en mi repositorio personal de desarrollo del proyecto "Tu Evento" (monorepo). Los 64 commits abarcan desarrollo full-stack intensivo con:

**Tecnologías principales:** Spring Boot (backend), React (web frontend), React Native (mobile), WebSocket/STOMP, PostgreSQL, Docker, MinIO, microservicios.

**Arquitecturas aplicadas:** DDD (Domain-Driven Design), arquitectura hexagonal, microservicios, CQRS, Event Sourcing.

**Módulos implementados:** Autenticación/autorización, sistema de asientos en tiempo real, gateway de pagos, gestión de tickets, wallet de usuario, sistema de notificaciones.

El repositorio es público y el instructor `ariel5253` tiene acceso completo. Todos los commits incluyen trabajo en múltiples ramas (principalmente `develop` y `main`) y siguen convenciones de Conventional Commits. El trabajo representa desarrollo profesional con patrones de arquitectura modernos y tecnologías de la industria.

---

*Declaro que la información de este informe es veraz y que los commits listados son de mi autoría.*

**Aprendiz:** Cristofer David Lozano Contreras **Fecha:** 6 de octubre de 2026
