# Таулы аймақтарға арналған офлайн навигация және төтенше жағдайларда SOS көмек шақыру жүйесі

Таулы аймақтарда интернет байланысы жоқ немесе әлсіз жағдайда офлайн карталармен бағдарлануға, маршрутпен жүруге және төтенше жағдайда GPS координаттарымен SOS көмек сигналын жіберуге арналған мобильді қосымша.

## Пайдаланушылар
- **Турист / Пайдаланушы:** Офлайн карталар мен маршруттарды жүктейді, GPS арқылы қозғалысты бақылайды, төтенше жағдайда SOS сигналын жібереді.
- **Құтқарушы / Диспетчер:** Келіп түскен SOS сигналдарын және координаттарды қабылдайды, көмек тобын бағыттайды, мәртебені жаңартады.
- **Администратор:** Офлайн карталар мен қауіпті аймақтар базасын жаңартады, пайдаланушы рөлдері мен жүйе параметрлерін басқарады.

## Құжаттама және диаграммалар
- Activity диаграммасы: `docs/analysis/activity-sos-request.drawio` және `docs/analysis/activity-sos-request.png`
- Sequence диаграммасы: `docs/analysis/sequence-sos-request.drawio` және `docs/analysis/sequence-sos-request.png`

### 13-апта: DFD, ERD және деректер қоры
* Контекстік DFD: [dfd-context.png](docs/analysis/dfd-context.png) ([dfd-context.drawio](docs/analysis/dfd-context.drawio))
* 0-деңгей DFD: [dfd-level0.png](docs/analysis/dfd-level0.png) ([dfd-level0.drawio](docs/analysis/dfd-level0.drawio))
* 1-деңгей DFD: [dfd-levell.png](docs/analysis/dfd-levell.png) ([dfd-levell.drawio](docs/analysis/dfd-levell.drawio))
* ERD диаграммасы: [erd.png](docs/database/erd.png) ([erd.drawio](docs/database/erd.drawio))
* SQL схемасы және сұраныстары: [schema.sql](docs/database/schema.sql)
* SQL сұраныстарының нәтижесі: [query-results.png](docs/database/query-results.png)
