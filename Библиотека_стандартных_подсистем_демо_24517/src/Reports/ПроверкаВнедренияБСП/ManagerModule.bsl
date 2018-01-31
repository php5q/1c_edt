#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ВариантыОтчетов

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВариантыОтчетов") Тогда
		МодульВариантыОтчетов = ОбщегоНазначения.ОбщийМодуль("ВариантыОтчетов");
		НастройкиВарианта = МодульВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ПоПодсистемамКонфигурации");
		НастройкиВарианта.Описание = НСтр("ru = 'Проверка внедрения по подсистемам конфигурации.'");
		НастройкиВарианта.НастройкиДляПоиска.КлючевыеСлова = НСтр("ru = 'Проверка внедрения по подсистемам конфигурации'");
		
		НастройкиВарианта = МодульВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ПоПодсистемамБСП");
		НастройкиВарианта.Описание = НСтр("ru = 'Проверка внедрения по подсистемам БСП.'");
		НастройкиВарианта.НастройкиДляПоиска.КлючевыеСлова = НСтр("ru = 'Проверка внедрения по подсистемам БСП'");
	КонецЕсли;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВариантыОтчетов

#КонецОбласти

#КонецОбласти

#КонецЕсли