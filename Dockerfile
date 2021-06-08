FROM node:10 as frontend-builder

WORKDIR /frontend
COPY package.json package-lock.json /frontend/
RUN npm install

COPY client /frontend/client
COPY webpack.config.js /frontend/
RUN npm run build

FROM redash/redash:8.0.0.b32245

COPY --from=frontend-builder /frontend/client/dist /app/client/dist
