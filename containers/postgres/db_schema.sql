CREATE TABLE filelookups (
  file_id SERIAL primary key,
  product_id VARCHAR (128),
  incidence DOUBLE PRECISION,
  emission DOUBLE PRECISION
);

-- what SRID should we use?  This is 4326, which is wrong
SELECT AddGeometryColumn ('my_schema','filelookups','location',4326,'POINT',2, false);

CREATE TABLE filemetadata (
  file_id INTEGER REFERENCES filelookups (file_id) PRIMARY KEY,
  filepath VARCHAR (256)
-- ... many columns to be added or we jumble them all together in a JSON column?
);

CREATE TABLE datatype (
  type_id SERIAL PRIMARY KEY,
  type VARCHAR (16)
);

CREATE TABLE spectra (
  spectra_id BIGSERIAL PRIMARY KEY,
  type_id INTEGER FOREIGN KEY REFERENCES datatype (type_id),
  file_id INTEGER FOREIGN KEY REFERENCES filelookups (file_id),
  spectra DOUBLE PRECISION[]
);
