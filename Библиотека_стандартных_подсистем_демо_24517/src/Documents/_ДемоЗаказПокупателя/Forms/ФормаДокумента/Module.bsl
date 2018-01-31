#Область ОписаниеПеременных

// СтандартныеПодсистемы.ОценкаПроизводительности
&НаКлиенте
Перем ИдентификаторЗамераПроведение;
// Конец СтандартныеПодсистемы.ОценкаПроизводительности

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	ПредыдущийСтатусЗаказа = Объект.СтатусЗаказа;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
	// СтандартныеПодсистемы.Взаимодействия
	Взаимодействия.ПодготовитьОповещения(ЭтотОбъект,Параметры);
	// Конец СтандартныеПодсистемы.Взаимодействия
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриСозданииНаСервере(ЭтотОбъект, Объект, "ГруппаКонтактнаяИнформация", ПоложениеЗаголовкаЭлементаФормы.Лево);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	ИнициализироватьПоляКонтактнойИнформации();
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	УстановитьВидимостьЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьСчетчикиСтрокТаблиц();
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ОбработкаПроверкиЗаполненияНаСервере(ЭтотОбъект, Объект, Отказ);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	УстановитьВидимостьЭлементов();
	
	// СтандартныеПодсистемы.КонтрольВеденияУчета
	КонтрольВеденияУчета.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтрольВеденияУчета
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.ОценкаПроизводительности
	Если ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
        
        ИдентификаторЗамераПроведение = ОценкаПроизводительностиКлиент.НачатьЗамерВремени();
		
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ОценкаПроизводительности
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация

КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.РаботаСФайлами
	РаботаСФайлами.ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи, Параметры);
	// Конец СтандартныеПодсистемы.РаботаСФайлами
	
	// СтандартныеПодсистемы.Взаимодействия
	Если ЗначениеЗаполнено(ВзаимодействиеОснование) Тогда
		Взаимодействия.ПриЗаписиПредметаИзФормы(
			ТекущийОбъект.Ссылка, ВзаимодействиеОснование, Отказ);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Взаимодействия
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.ШаблоныСообщений
	Если ТекущийОбъект.СтатусЗаказа <> ПредыдущийСтатусЗаказа
		И ТекущийОбъект.УведомлятьОбИзменениеСтатусаЗаказа Тогда
			Результат = ШаблоныСообщений.СформироватьСообщениеИОтправить(ТекущийОбъект.ШаблонСообщения, ТекущийОбъект.Ссылка, УникальныйИдентификатор);
			ПредыдущийСтатусЗаказа = ТекущийОбъект.СтатусЗаказа;
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ШаблоныСообщений
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.ОценкаПроизводительности
	Если ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
        
        ОценкаПроизводительностиКлиент.УстановитьКлючевуюОперациюЗамера(ИдентификаторЗамераПроведение, "_ДемоЗаказПокупателяПроведение");
		
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ОценкаПроизводительности
	
	// СтандартныеПодсистемы.Взаимодействия
	ВзаимодействияКлиент.ВзаимодействиеПредметПослеЗаписи(ЭтотОбъект,Объект,ПараметрыЗаписи,"_ДемоЗаказПокупателя");
	// Конец СтандартныеПодсистемы.Взаимодействия
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КонтрагентПриИзменении(Элемент)
	
	УстановитьВидимостьЭлементов();
	
КонецПроцедуры

// СтандартныеПодсистемы.КонтактнаяИнформация

// Демонстрация программного интерфейса для размещения полей контактной информации в форме.

&НаКлиенте
Процедура ПредставлениеАдресаДоставкиПриИзменении(Элемент)
	
	Текст = Элемент.ТекстРедактирования;
	Если ПустаяСтрока(Текст) Тогда
		// Очистка данных, сбрасываем как представления, так и внутренние значения полей.
		ПредставлениеАдресаДоставки = "";
		КомментарийАдресаДоставки   = "";
		Объект.АдресДоставки        = "";
		Возврат;
	КонецЕсли;
		
	// Формируем внутренние значения полей по тексту и параметрам формирования из
	// реквизита ВидКонтактнойИнформацииАдресаДоставки.
	ПредставлениеАдресаДоставки = Текст;
	Объект.АдресДоставки = ЗначенияПолейКонтактнойИнформацииСервер(Текст, ВидКонтактнойИнформацииАдресаДоставки, КомментарийАдресаДоставки);
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеАдресаДоставкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	// Если представление было изменено в поле и сразу нажата кнопка выбора, то необходимо 
	// привести данные в соответствие и сбросить внутренние поля для повторного разбора.
	Если Элемент.ТекстРедактирования <> ПредставлениеАдресаДоставки Тогда
		ПредставлениеАдресаДоставки = Элемент.ТекстРедактирования;
		Объект.АдресДоставки        = "";
	КонецЕсли;
	
	// Данные для редактирования
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ВидКонтактнойИнформации", ВидКонтактнойИнформацииАдресаДоставки);
	ПараметрыОткрытия.Вставить("ЗначенияПолей",           Объект.АдресДоставки);
	ПараметрыОткрытия.Вставить("Представление",           ПредставлениеАдресаДоставки);
	ПараметрыОткрытия.Вставить("Комментарий",             КомментарийАдресаДоставки);
	
	// Переопределямый заголовок формы, по умолчанию отобразятся данные по ВидКонтактнойИнформации.
	ПараметрыОткрытия.Вставить("Заголовок", НСтр("ru='Адрес доставки'"));
	
	УправлениеКонтактнойИнформациейКлиент.ОткрытьФормуКонтактнойИнформации(ПараметрыОткрытия, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеАдресаДоставкиОчистка(Элемент, СтандартнаяОбработка)
	// Сбрасываем как представления, так и внутренние значения полей.
	ПредставлениеАдресаДоставки = "";
	КомментарийАдресаДоставки   = "";
	Объект.АдресДоставки        = "";
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеАдресаДоставкиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Если ТипЗнч(ВыбранноеЗначение)<>Тип("Структура") Тогда
		// Отказ от выбора, данные неизменны.
		Возврат;
	КонецЕсли;
	
	ПредставлениеАдресаДоставки = ВыбранноеЗначение.Представление;
	КомментарийАдресаДоставки   = ВыбранноеЗначение.Комментарий;
	Объект.АдресДоставки        = ВыбранноеЗначение.КонтактнаяИнформация;
КонецПроцедуры

&НаКлиенте
Процедура КомментарийАдресаДоставкиПриИзменении(Элемент)
	ЗаполнитьКомментарийАдресаДоставкиСервер();
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеЭлектроннойПочтыПриИзменении(Элемент)
	Текст = Элемент.ТекстРедактирования;
	Если ПустаяСтрока(Текст) Тогда
		// Очистка данных, сбрасываем как представления, так и внутренние значения полей.
		ПредставлениеЭлектроннойПочты = "";
		Объект.ЭлектроннаяПочта       = "";
		Возврат;
	КонецЕсли;
		
	// Формируем внутренние значения полей по тексту и параметрам формирования из
	// реквизита ВидКонтактнойИнформацииЭлектроннойПочты.
	ПредставлениеЭлектроннойПочты = Текст;
	Объект.ЭлектроннаяПочта = ЗначенияПолейКонтактнойИнформацииСервер(Текст, ВидКонтактнойИнформацииЭлектроннойПочты);
КонецПроцедуры

// Конец СтандартныеПодсистемы.КонтактнаяИнформация

// СтандартныеПодсистемы.ШаблоныСообщений

&НаКлиенте
Процедура ШаблонСообщенияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Оповещение = Новый ОписаниеОповещения("ПослеВыбораШаблона", ЭтотОбъект);
	ШаблоныСообщенийКлиент.ВыбратьШаблон(Оповещение, "Письмо", Объект.Ссылка);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ШаблоныСообщений

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСчетаНаОплату

&НаКлиенте
Процедура СчетаНаОплатуПриИзменении(Элемент)
	ОбновитьСчетчикиСтрокТаблиц();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПартнерыИКонтактныеЛица

&НаКлиенте
Процедура ПартнерыИКонтактныеЛицаПриИзменении(Элемент)
	ОбновитьСчетчикиСтрокТаблиц();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НаписатьЭлектронноеПисьмо(Команда)
	
	УправлениеКонтактнойИнформациейКлиент.СоздатьЭлектронноеПисьмо(Объект.ЭлектроннаяПочта,
		ПредставлениеЭлектроннойПочты, ВидКонтактнойИнформацииЭлектроннойПочты, Объект.Партнер);
		
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	ЗаблокированныеРеквизиты = ЗапретРедактированияРеквизитовОбъектовКлиент.Реквизиты(ЭтотОбъект);
	
	Если ЗаблокированныеРеквизиты.Количество() > 0 Тогда
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Ссылка", Объект.Ссылка);
		ПараметрыФормы.Вставить("ЗаблокированныеРеквизиты", ЗаблокированныеРеквизиты);
		
		ОткрытьФорму("Документ._ДемоЗаказПокупателя.Форма.РазблокированиеРеквизитов", ПараметрыФормы,
			ЭтотОбъект,,,, Новый ОписаниеОповещения("ПослеВыбораРеквизитовДляРазблокирования", ЭтотОбъект));
	Иначе
		ЗапретРедактированияРеквизитовОбъектовКлиент.ПоказатьПредупреждениеВсеВидимыеРеквизитыРазблокированы();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораРеквизитовДляРазблокирования(РазблокируемыеРеквизиты, Контекст) Экспорт
	
	Если ТипЗнч(РазблокируемыеРеквизиты) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	ЗапретРедактированияРеквизитовОбъектовКлиент.УстановитьДоступностьЭлементовФормы(ЭтотОбъект,
		РазблокируемыеРеквизиты);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

&НаСервере
Процедура УстановитьВидимостьЭлементов()
	
	Если ЗначениеЗаполнено(Объект.Контрагент) Тогда
		ВидКонтрагента = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Контрагент, "ВидКонтрагента");
	Иначе
		ВидКонтрагента = Неопределено;
	КонецЕсли;
	
	Элементы.Договор.Видимость = ВидКонтрагента <> Перечисления._ДемоЮридическоеФизическоеЛицо.ФизическоеЛицо;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСчетчикиСтрокТаблиц()
	
	Элементы.СтраницаСчетаНаОплату.Заголовок = 
		?(Объект.СчетаНаОплату.Количество() > 0, 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Счета на оплату (%1)'"), Объект.СчетаНаОплату.Количество()),
			НСтр("ru = 'Счета на оплату'"));
	Элементы.СтраницаПартнерыИКонтактныеЛица.Заголовок = 
		?(Объект.ПартнерыИКонтактныеЛица.Количество() > 0, 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Контактные лица (%1)'"), Объект.ПартнерыИКонтактныеЛица.Количество()),
			НСтр("ru = 'Контактные лица'"));
	
КонецПроцедуры

// СтандартныеПодсистемы.КонтактнаяИнформация

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриИзменении(Элемент)
	УправлениеКонтактнойИнформациейКлиент.ПриИзменении(ЭтотОбъект, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачалоВыбора(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриНажатии(Элемент, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачалоВыбора(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОчистка(Элемент, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.Очистка(ЭтотОбъект, Элемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияВыполнитьКоманду(Команда)
	УправлениеКонтактнойИнформациейКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда.Имя);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ОбновитьКонтактнуюИнформацию(Результат)
	УправлениеКонтактнойИнформацией.ОбновитьКонтактнуюИнформацию(ЭтотОбъект, Объект, Результат);
КонецПроцедуры

// Демонстрация программного интерфейса для размещения полей контактной информации в форме.

&НаСервере
Процедура ИнициализироватьПоляКонтактнойИнформации()
	
	// Реквизит формы, контролирующий работу с адресом доставки.
	// Используемые поля аналогичны полям справочника ВидыКонтактнойИнформации.
	ВидКонтактнойИнформацииАдресаДоставки = Новый Структура;
	ВидКонтактнойИнформацииАдресаДоставки.Вставить("Тип", Перечисления.ТипыКонтактнойИнформации.Адрес);
	ВидКонтактнойИнформацииАдресаДоставки.Вставить("ТолькоНациональныйАдрес",        Истина);
	ВидКонтактнойИнформацииАдресаДоставки.Вставить("ВключатьСтрануВПредставление", Ложь);
	ВидКонтактнойИнформацииАдресаДоставки.Вставить("СкрыватьНеактуальныеАдреса",   Ложь);
	
	// Аналогичные реквизиты для электронной почты.
	ВидКонтактнойИнформацииЭлектроннойПочты = Новый Структура;
	ВидКонтактнойИнформацииЭлектроннойПочты.Вставить("Тип", Перечисления.ТипыКонтактнойИнформации.АдресЭлектроннойПочты);
	
	// Считываем данные из полей адреса в реквизиты для редактирования.
	ПредставлениеАдресаДоставки = УправлениеКонтактнойИнформацией.ПредставлениеКонтактнойИнформации(Объект.АдресДоставки);
	КомментарийАдресаДоставки   = УправлениеКонтактнойИнформацией.КомментарийКонтактнойИнформации(Объект.АдресДоставки);
	
	ПредставлениеЭлектроннойПочты = УправлениеКонтактнойИнформацией.ПредставлениеКонтактнойИнформации(Объект.ЭлектроннаяПочта);
КонецПроцедуры

// Устанавливаем новый комментарий для адреса доставки.
// 
&НаСервере
Процедура ЗаполнитьКомментарийАдресаДоставкиСервер()
	
	Если ПустаяСтрока(Объект.АдресДоставки) Тогда
		// Необходимо инициализировать данные.
		Объект.АдресДоставки = ЗначенияПолейКонтактнойИнформацииСервер(ПредставлениеАдресаДоставки, ВидКонтактнойИнформацииАдресаДоставки, КомментарийАдресаДоставки);
		Возврат;
	КонецЕсли;
	
	УправлениеКонтактнойИнформацией.УстановитьКомментарийКонтактнойИнформации(Объект.АдресДоставки, КомментарийАдресаДоставки);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗначенияПолейКонтактнойИнформацииСервер(Знач Представление, Знач ВидКонтактнойИнформации, Знач Комментарий = Неопределено)
	
	// Создаем новый экземпляр по представлению.
	Результат = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияXMLПоПредставлению(Представление, ВидКонтактнойИнформации);
	
	Возврат Результат;
КонецФункции

// Конец СтандартныеПодсистемы.КонтактнаяИнформация

// СтандартныеПодсистемы.КонтрольВеденияУчета

&НаКлиенте
Процедура Подключаемый_ОткрытьОтчетПоПроблемам(ЭлементИлиКоманда, НавигационнаяСсылка, СтандартнаяОбработка)
	КонтрольВеденияУчетаКлиент.ОткрытьОтчетПоПроблемамОбъекта(ЭтотОбъект, Объект.Ссылка, СтандартнаяОбработка);
КонецПроцедуры

// Конец СтандартныеПодсистемы.КонтрольВеденияУчета

// СтандартныеПодсистемы.ШаблоныСообщений

&НаКлиенте
Процедура ПослеВыбораШаблона(Шаблон, ДополнительныеПараметры) Экспорт
	Если Шаблон <> Неопределено Тогда
		Объект.ШаблонСообщения = Шаблон;
		Модифицированность = Истина;
	КонецЕсли;
КонецПроцедуры

// Конец СтандартныеПодсистемы.ШаблоныСообщений

#КонецОбласти
