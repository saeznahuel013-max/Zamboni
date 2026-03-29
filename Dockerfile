FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiamos todo el contenido al contenedor
COPY . .

# Usamos un comodín (*) para que encuentre el archivo sin importar la ruta exacta
RUN dotnet restore **/*.csproj
RUN dotnet publish **/*.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# El nombre de la DLL suele ser el mismo que el del proyecto principal
# Si falla aquí, probaremos con Zamboni.dll a secas
ENTRYPOINT ["dotnet", "Zamboni.Server.dll"]
