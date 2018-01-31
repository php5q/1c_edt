
#Область СлужебныйПрограммныйИнтерфейс

// Вызывается при получении уведомления о новых данных.
// В теле следует проверить, необходимы ли эти данные приложению, 
// и если да - установить флажок Загружать.
// 
// Параметры:
//   Дескриптор - ОбъектXDTO - Дескриптор.
//   Загружать - Булево - Истина, если загружать, Ложь - иначе.
//
Процедура ДоступныНовыеДанные(Знач Дескриптор, Загружать) Экспорт
	
 	Если Дескриптор.DataType = "ПроизвКалендари" Тогда
		Загружать = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Вызывается после вызова ДоступныНовыеДанные, позволяет разобрать данные.
//
// Параметры:
//   Дескриптор - ОбъектXDTO - Дескриптор.
//   ПутьКФайлу - Строка - полное имя извлеченного файла. Файл будет автоматически удален 
//                  после завершения процедуры. Если в менеджере сервиса не был
//                  указан файл - значение аргумента равно Неопределено.
//
Процедура ОбработатьНовыеДанные(Знач Дескриптор, Знач ПутьКФайлу) Экспорт
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ПутьКФайлу);
	ЧтениеXML.ПерейтиКСодержимому();
	Если Не НачалоЭлемента(ЧтениеXML, "CalendarSuppliedData") Тогда
		Возврат;
	КонецЕсли;
	ЧтениеXML.Прочитать();
	Если Не НачалоЭлемента(ЧтениеXML, "Calendars") Тогда
		Возврат;
	КонецЕсли;
	
	// Обновляем список производственных календарей.
	ТаблицаКалендарей = ОбщегоНазначения.ПрочитатьXMLВТаблицу(ЧтениеXML).Данные;
	Справочники.ПроизводственныеКалендари.ОбновитьПроизводственныеКалендари(ТаблицаКалендарей);
	
	ЧтениеXML.Прочитать();
	Если Не КонецЭлемента(ЧтениеXML, "Calendars") Тогда
		Возврат;
	КонецЕсли;
	ЧтениеXML.Прочитать();
	Если Не НачалоЭлемента(ЧтениеXML, "CalendarData") Тогда
		Возврат;
	КонецЕсли;
	
	// Обновляем данные производственных календарей.
	ТаблицаДанных = Справочники.ПроизводственныеКалендари.ДанныеПроизводственныхКалендарейИзXML(ЧтениеXML);
	
	ТаблицаИзменений = Справочники.ПроизводственныеКалендари.ОбновитьДанныеПроизводственныхКалендарей(ТаблицаДанных);
	КалендарныеГрафики.РаспространитьИзмененияДанныхПроизводственныхКалендарей(ТаблицаИзменений);
	
КонецПроцедуры

// Вызывается при отмене обработки данных в случае сбоя.
//
// Параметры:
//   Дескриптор - ОбъектXDTO - Дескриптор.
//
Процедура ОбработкаДанныхОтменена(Знач Дескриптор) Экспорт 
	
	ПоставляемыеДанные.ОбластьОбработана(Дескриптор.FileGUID, "ДанныеПроизводственныхКалендарей", Неопределено);
	
КонецПроцедуры	

// Вызывается при изменении производственных календарей.
//
Процедура ЗапланироватьОбновлениеГрафиковРаботы(Знач УсловияОбновления) Экспорт
	
	ПараметрыМетода = Новый Массив;
	ПараметрыМетода.Добавить(УсловияОбновления);
	ПараметрыМетода.Добавить(Новый УникальныйИдентификатор);

	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("ИмяМетода"    , "КалендарныеГрафикиСлужебныйВМоделиСервиса.ОбновитьГрафикиРаботы");
	ПараметрыЗадания.Вставить("Параметры"    , ПараметрыМетода);
	ПараметрыЗадания.Вставить("КоличествоПовторовПриАварийномЗавершении", 3);
	ПараметрыЗадания.Вставить("ОбластьДанных", -1);
	
	УстановитьПривилегированныйРежим(Истина);
	ОчередьЗаданий.ДобавитьЗадание(ПараметрыЗадания);

КонецПроцедуры

// Вызывается при изменении производственных календарей.
//
Процедура ЗапланироватьОбновлениеДанныхЗависимыхОтПроизводственныхКалендарей(Знач УсловияОбновления) Экспорт
	
	ПараметрыМетода = Новый Массив;
	ПараметрыМетода.Добавить(УсловияОбновления);

	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("ИмяМетода"    , "КалендарныеГрафикиПереопределяемый.ПриОбновленииДанныхЗависимыхОтПроизводственныхКалендарей");
	ПараметрыЗадания.Вставить("Параметры"    , ПараметрыМетода);
	ПараметрыЗадания.Вставить("КоличествоПовторовПриАварийномЗавершении", 3);
	ПараметрыЗадания.Вставить("ОбластьДанных", -1);
	
	УстановитьПривилегированныйРежим(Истина);
	ОчередьЗаданий.ДобавитьЗадание(ПараметрыЗадания);

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий подсистем конфигурации.

// См. ПоставляемыеДанныеПереопределяемый.ПолучитьОбработчикиПоставляемыхДанных.
Процедура ПриОпределенииОбработчиковПоставляемыхДанных(Обработчики) Экспорт
	
	ЗарегистрироватьОбработчикиПоставляемыхДанных(Обработчики);
	
КонецПроцедуры

// См. ОчередьЗаданийПереопределяемый.ПриОпределенииПсевдонимовОбработчиков.
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
	
	СоответствиеИменПсевдонимам.Вставить("КалендарныеГрафикиСлужебныйВМоделиСервиса.ОбновитьГрафикиРаботы");
	СоответствиеИменПсевдонимам.Вставить("КалендарныеГрафикиПереопределяемый.ПриОбновленииДанныхЗависимыхОтПроизводственныхКалендарей");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Регистрирует обработчики поставляемых данных за день и за все время.
//
// Параметры:
//     Обработчики - ТаблицаЗначений - таблица для добавления обработчиков. Содержит колонки.
//       * ВидДанных - Строка - код вида данных, обрабатываемый обработчиком.
//       * КодОбработчика - Строка - будет использоваться при восстановлении обработки данных после сбоя.
//       * Обработчик - ОбщийМодуль - модуль, содержащий экспортные  процедуры:
//                                          ДоступныНовыеДанные(Дескриптор, Загружать) Экспорт  
//                                          ОбработатьНовыеДанные(Дескриптор, ПутьКФайлу) Экспорт
//                                          ОбработкаДанныхОтменена(Дескриптор) Экспорт
//
Процедура ЗарегистрироватьОбработчикиПоставляемыхДанных(Знач Обработчики)
	
	Обработчик = Обработчики.Добавить();
	Обработчик.ВидДанных = "ПроизвКалендари";
	Обработчик.КодОбработчика = "ДанныеПроизводственныхКалендарей";
	Обработчик.Обработчик = КалендарныеГрафикиСлужебныйВМоделиСервиса;
	
КонецПроцедуры

// Процедура для вызова из очереди заданий, помещается туда в ЗапланироватьОбновлениеГрафиковРаботы.
// 
// Параметры:
//  УсловияОбновления - ТаблицаЗначений с условиями обновления графиков.
//  ИдентификаторФайла - УникальныйИдентификатор файла обрабатываемых поставляемых данных.
//
Процедура ОбновитьГрафикиРаботы(Знач УсловияОбновления, Знач ИдентификаторФайла) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ГрафикиРаботы") Тогда
		
		МодульГрафикиРаботы = ОбщегоНазначения.ОбщийМодуль("ГрафикиРаботы");
		
		// Получение областей данных для обработки.
		ОбластиДляОбновления = ПоставляемыеДанные.ОбластиТребующиеОбработки(
			ИдентификаторФайла, "ДанныеПроизводственныхКалендарей");
			
		// Обновление графиков работы по областям данных.
		РаспространитьДанныеПроизводственныхКалендарейПоГрафикамРаботы(УсловияОбновления, ОбластиДляОбновления, 
			ИдентификаторФайла, "ДанныеПроизводственныхКалендарей", МодульГрафикиРаботы);
			
	КонецЕсли;

КонецПроцедуры

// Заполняет данные графика работы по данным производственного календаря по всем ОД.
//
// Параметры:
//  ДатаКурсов - Дата или Неопределено. Курсы добавляются за указанную дату либо за все время.
//  УсловияОбновления - ТаблицаЗначений с условиями обновления графиков.
//  ОбластиДляОбновления - Массив со списком кодов областей.
//  ИдентификаторФайла - УникальныйИдентификатор файла обрабатываемых курсов.
//  КодОбработчика - Строка, код обработчика.
//
Процедура РаспространитьДанныеПроизводственныхКалендарейПоГрафикамРаботы(Знач УсловияОбновления, 
	Знач ОбластиДляОбновления, Знач ИдентификаторФайла, Знач КодОбработчика, Знач МодульГрафикиРаботы)
	
	УсловияОбновления.Свернуть("КодПроизводственногоКалендаря, Год");
	
	Для каждого ОбластьДанных Из ОбластиДляОбновления Цикл
	
		УстановитьПривилегированныйРежим(Истина);
		РаботаВМоделиСервиса.УстановитьРазделениеСеанса(Истина, ОбластьДанных);
		УстановитьПривилегированныйРежим(Ложь);
		
		НачатьТранзакцию();
		
		Попытка
			
			МодульГрафикиРаботы.ОбновитьГрафикиРаботыПоДаннымПроизводственныхКалендарей(УсловияОбновления);
			ПоставляемыеДанные.ОбластьОбработана(ИдентификаторФайла, КодОбработчика, ОбластьДанных);
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Поставляемые данные.Календарные графики'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
									УровеньЖурналаРегистрации.Ошибка,,,
									ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// Прочие служебные процедуры и функции.

Функция НачалоЭлемента(Знач ЧтениеXML, Знач Имя)
	
	Если ЧтениеXML.ТипУзла <> ТипУзлаXML.НачалоЭлемента Или ЧтениеXML.Имя <> Имя Тогда
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Поставляемые данные.Календарные графики'", 
			ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()), УровеньЖурналаРегистрации.Ошибка,
			,, СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Неверный формат файла данных. Ожидается начало элемента %1'"), Имя));
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

Функция КонецЭлемента(Знач ЧтениеXML, Знач Имя)
	
	Если ЧтениеXML.ТипУзла <> ТипУзлаXML.КонецЭлемента Или ЧтениеXML.Имя <> Имя Тогда
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Поставляемые данные.Календарные графики'", 
			ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()), УровеньЖурналаРегистрации.Ошибка,
			,, СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Неверный формат файла данных. Ожидается конец элемента %1'"), Имя));
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти
