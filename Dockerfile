FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Esto copia TODO el contenido de tu GitHub al servidor
COPY . .

# Usamos este comando para que busque el proyecto solito, sin importar el nombre de la carpeta
RUN dotnet restore $(find . -name "*.csproj")
RUN dotnet publish $(find . -name "*.csproj") -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Ejecutamos el servidor (aquí no importa la carpeta, solo el nombre del archivo final)
ENTRYPOINT ["dotnet", "Zamboni.Server.dll"]
