DROP TABLE IF EXISTS rescue_dispatches;
DROP TABLE IF EXISTS sos_requests;
DROP TABLE IF EXISTS map_assignments;
DROP TABLE IF EXISTS offline_maps;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    role_name VARCHAR(30) NOT NULL CHECK (role_name IN ('Турист', 'Құтқарушы / Диспетчер', 'Әкімші')),
    phone VARCHAR(25) NOT NULL
);

CREATE TABLE offline_maps (
    map_id SERIAL PRIMARY KEY,
    region_name VARCHAR(120) NOT NULL,
    route_title VARCHAR(150) NOT NULL,
    difficulty_level VARCHAR(30) NOT NULL,
    size_mb NUMERIC(6,1) NOT NULL CHECK (size_mb > 0)
);

CREATE TABLE map_assignments (
    assignment_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    map_id INTEGER NOT NULL REFERENCES offline_maps(map_id) ON DELETE CASCADE,
    assigned_role VARCHAR(30) NOT NULL,
    status VARCHAR(30) NOT NULL,
    UNIQUE (user_id, map_id)
);

CREATE TABLE sos_requests (
    sos_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    map_id INTEGER NOT NULL REFERENCES offline_maps(map_id) ON DELETE RESTRICT,
    latitude NUMERIC(9,6) NOT NULL,
    longitude NUMERIC(9,6) NOT NULL,
    delivery_mode VARCHAR(20) NOT NULL CHECK (delivery_mode IN ('ONLINE', 'OFFLINE_QUEUE')),
    status VARCHAR(30) NOT NULL
);

CREATE TABLE rescue_dispatches (
    dispatch_id SERIAL PRIMARY KEY,
    sos_id INTEGER NOT NULL REFERENCES sos_requests(sos_id) ON DELETE CASCADE,
    dispatcher_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE RESTRICT,
    team_name VARCHAR(100) NOT NULL,
    dispatch_status VARCHAR(30) NOT NULL
);

INSERT INTO users (full_name, role_name, phone) VALUES
('Ақерке Жақсыбай', 'Турист', '+77011112233'),
('Данияр Серіков', 'Турист', '+77022223344'),
('Марат Нұрланов', 'Құтқарушы / Диспетчер', '+77053334455'),
('Әсел Төлегенова', 'Әкімші', '+77074445566');

INSERT INTO offline_maps (region_name, route_title, difficulty_level, size_mb) VALUES
('Іле Алатауы', 'Үлкен Алматы көлі — Туристік асу', 'Орташа', 145.5),
('Іле Алатауы', 'Шымбұлақ — Талғар асуы', 'Күрделі', 210.0),
('Көлсай көлдері', 'Көлсай 1 — Қайыңды бағыты', 'Жеңіл', 98.4),
('Жоңғар Алатауы', 'Жасылкөл — Биік жота', 'Күрделі', 265.2);

INSERT INTO map_assignments (user_id, map_id, assigned_role, status) VALUES
(1, 1, 'Турист', 'Жүктелді'),
(1, 2, 'Турист', 'Кэште сақталды'),
(2, 2, 'Турист', 'Жүктелді'),
(2, 3, 'Турист', 'Жүктелді'),
(4, 1, 'Әкімші', 'Расталды');

INSERT INTO sos_requests (user_id, map_id, latitude, longitude, delivery_mode, status) VALUES
(1, 2, 43.168400, 77.081200, 'OFFLINE_QUEUE', 'Кезекте тұр'),
(2, 2, 43.152100, 77.094500, 'ONLINE', 'Қабылданды'),
(1, 1, 43.051800, 76.984100, 'ONLINE', 'Жабылды'),
(2, 3, 42.998500, 78.321900, 'OFFLINE_QUEUE', 'Жіберілді');

INSERT INTO rescue_dispatches (sos_id, dispatcher_id, team_name, dispatch_status) VALUES
(1, 3, 'Алматы ТЖМ №1 тау тобы', 'Шығуға дайын'),
(2, 3, 'Медеу құтқару бөлімшесі', 'Жолда'),
(3, 3, 'Іле-Алатау кезекші тобы', 'Аяқталды');

SELECT
    s.sos_id,
    u.full_name AS tourist_name,
    m.route_title,
    s.latitude,
    s.longitude,
    s.delivery_mode,
    s.status
FROM sos_requests s
JOIN users u ON s.user_id = u.user_id
JOIN offline_maps m ON s.map_id = m.map_id
ORDER BY s.sos_id;

SELECT
    delivery_mode,
    COUNT(*) AS total_requests
FROM sos_requests
GROUP BY delivery_mode
ORDER BY delivery_mode;
