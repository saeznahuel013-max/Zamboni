FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiamos absolutamente todo el repositorio al servidor de Railway
COPY . .

# Entramos a la carpeta donde está el archivo de solución (.sln) o el proyecto
# Y restauramos todo de una sola vez
RUN dotnet restore Zamboni14Legacy.sln || dotnet restore Zamboni.Server/Zamboni.Server.csproj || dotnet restore Zamboni14Legacy.csproj

# Compilamos ignorando las advertencias de versiones viejas (como la de HashLib)
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# El nombre del archivo que arranca el servidor
ENTRYPOINT ["dotnet", "Zamboni14Legacy.dll"]
