SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfoliooProject.dbo.CovidDeaths
ORDER BY 1,2

--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract in your country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfoliooProject.dbo.CovidDeaths
WHERE location like '%Bangladesh%'
ORDER BY 1,2

--Looking at Total Cases vs Population
--Show what percentage of population got covid

SELECT location, date, total_cases, population, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfoliooProject.dbo.CovidDeaths
--WHERE location like '%Bangladesh%'
ORDER BY 1,2

--Looking at Countries with Highest Infaction Rate compared to Population

SELECT location, population, MAX(total_cases) AS HighestInfactionCount, MAX(total_cases/population)*100 AS PercentPopulationInfected
FROM PortfoliooProject.dbo.CovidDeaths
--WHERE location like '%Bangladesh%'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC


--Showing Countries with Highest Death Count per Population

SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfoliooProject.dbo.CovidDeaths
--WHERE location like '%Bangladesh%'
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC

--Let's Break Things Down By Continent

SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfoliooProject.dbo.CovidDeaths
--WHERE location like '%Bangladesh%'
WHERE continent is  null
GROUP BY location
ORDER BY TotalDeathCount DESC

--owing contintents with the highest death count per population
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfoliooProject.dbo.CovidDeaths
--WHERE location like '%Bangladesh%'
WHERE continent is  not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

--GLOBAL NUMBER
SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths, SUM(CAST(new_deaths AS int))/SUM(New_Cases)*100 AS DeathPercentage
FROM PortfoliooProject.dbo.CovidDeaths
WHERE continent is not null
ORDER BY 1,2

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfoliooProject.dbo.CovidDeaths dea
JOIN PortfoliooProject.dbo.CovidVaccinations vac
    ON dea.location = vac.location
	and dea.date = vac.date 
WHERE dea.continent is not null
ORDER BY 2,3
