% ===== KOA Combined Output | contract_id: contrato_ocs_278_2023 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_278_2023_-_ORACLE.pl
% contract_id: contrato_ocs_278_2023

instance_of(contrato_ocs_278_2023, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(oracle_do_brasil_sistemas_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_278_2023).
plays_role(oracle_do_brasil_sistemas_ltda, hired_service_provider_role, contrato_ocs_278_2023).

clause_of(clausula_primeira_objeto, contrato_ocs_278_2023).
clause_of(clausula_segunda_vigencia, contrato_ocs_278_2023).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_278_2023).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_278_2023).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_278_2023).
clause_of(clausula_sexta_preco, contrato_ocs_278_2023).
clause_of(clausula_setima_pagamento, contrato_ocs_278_2023).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_278_2023).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_278_2023).
clause_of(clausula_decima_primeira_obrigações_contratado, contrato_ocs_278_2023).
clause_of(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, contrato_ocs_278_2023).
clause_of(clausula_decima_terceira_sigilo_das_informacoes, contrato_ocs_278_2023).
clause_of(clausula_decima_quarta_acesso_protecao_dados_pessoais, contrato_ocs_278_2023).
clause_of(clausula_decima_quinta_obrigacoes_bndes, contrato_ocs_278_2023).
clause_of(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, contrato_ocs_278_2023).
clause_of(clausula_decima_oitava_penalidades, contrato_ocs_278_2023).
clause_of(clausula_decima_nona_alteracoes_contratuais, contrato_ocs_278_2023).
clause_of(clausula_vigesima_extincao_contrato, contrato_ocs_278_2023).
clause_of(clausula_vigesima_primeira_disposicoes_finais, contrato_ocs_278_2023).
clause_of(clausula_vigesima_segunda_foro, contrato_ocs_278_2023).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_278_2023).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, oracle_do_brasil_sistemas_ltda, provide_technical_support).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_technical_support).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, oracle_do_brasil_sistemas_ltda, present_manifestation_on_contract_extension).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, oracle_do_brasil_sistemas_ltda, communicate_interest_in_contract_extension).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, oracle_do_brasil_sistemas_ltda, execute_object_according_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object_according_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, oracle_do_brasil_sistemas_ltda, execute_services_according_to_policy).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, oracle_do_brasil_sistemas_ltda, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, oracle_do_brasil_sistemas_ltda, subjection_to_penalties).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, efetuar_recebimento_objeto).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receber_objeto).
legal_relation_instance(clausula_sexta_preco, duty_to_act, oracle_do_brasil_sistemas_ltda, bear_costs_quantification_error).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, oracle_do_brasil_sistemas_ltda, demand_indemnification_no_total_demand).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, right_to_action, oracle_do_brasil_sistemas_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, duty_to_act, oracle_do_brasil_sistemas_ltda, execute_contract_object).
legal_relation_instance(clausula_sexta_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_contract_object).
legal_relation_instance(clausula_sexta_preco, subjection, oracle_do_brasil_sistemas_ltda, payment_reduction_partial_execution).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, oracle_do_brasil_sistemas_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, oracle_do_brasil_sistemas_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, discount_penalties).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, oracle_do_brasil_sistemas_ltda, send_documents).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_late_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, oracle_do_brasil_sistemas_ltda, provide_tax_exemption_proof).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_charging_interest_when_contracted_party_fault).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, oracle_do_brasil_sistemas_ltda, formulate_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, oracle_do_brasil_sistemas_ltda, prove_triggering_event).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, oracle_do_brasil_sistemas_ltda, request_price_adjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, oracle_do_brasil_sistemas_ltda, provide_requested_information).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, oracle_do_brasil_sistemas_ltda, request_reajustment_or_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_reajustment_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, oracle_do_brasil_sistemas_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, negotiate_price_reduction).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, oracle_do_brasil_sistemas_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_period).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, oracle_do_brasil_sistemas_ltda, notify_entity_of_contract_extension).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_omit, oracle_do_brasil_sistemas_ltda, fail_to_provide_contractual_guarantee).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, maintain_conditions_of_qualification).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, communicate_impediment_to_contracting).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, repair_correct_remove_replace_object).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, repair_damages_to_bndes_or_third_parties).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, pay_all_taxes_and_fees).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, assume_responsibility_for_charges).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, prove_exclusion_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, permit_fiscalization_and_monitoring).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, follow_inspection_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oracle_do_brasil_sistemas_ltda, designate_representative).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, oracle_do_brasil_sistemas_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, oracle_do_brasil_sistemas_ltda, offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, oracle_do_brasil_sistemas_ltda, prevent_bndes_employee_favoritism).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, oracle_do_brasil_sistemas_ltda, allow_bndes_employee_favoritism).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, oracle_do_brasil_sistemas_ltda, prevent_allocation_of_bndes_employees_relatives).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, oracle_do_brasil_sistemas_ltda, allocate_bndes_employees_relatives).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, oracle_do_brasil_sistemas_ltda, know_bndes_ethics_policy).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, oracle_do_brasil_sistemas_ltda, adopt_environmental_practices).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, oracle_do_brasil_sistemas_ltda, report_conflict_of_interest).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, oracle_do_brasil_sistemas_ltda, notify_government_investigation).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, oracle_do_brasil_sistemas_ltda, know_bndes_information_security_policies).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, oracle_do_brasil_sistemas_ltda, not_access_confidential_information).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, oracle_do_brasil_sistemas_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, oracle_do_brasil_sistemas_ltda, not_copy_reproduce_or_retain_info).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, oracle_do_brasil_sistemas_ltda, limit_access_to_information).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, oracle_do_brasil_sistemas_ltda, report_security_breaches).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, oracle_do_brasil_sistemas_ltda, return_bndes_property).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, oracle_do_brasil_sistemas_ltda, not_use_confidential_info_after_contract).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, oracle_do_brasil_sistemas_ltda, observe_confidentiality_term).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oracle_do_brasil_sistemas_ltda, adopt_good_governance_measures).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oracle_do_brasil_sistemas_ltda, follow_bndes_instructions).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, share_data_without_authorization).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oracle_do_brasil_sistemas_ltda, maintain_data_confidentiality).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oracle_do_brasil_sistemas_ltda, inform_employees_data_clauses).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, regress_against_contracted_party).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oracle_do_brasil_sistemas_ltda, provide_data_access_system).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oracle_do_brasil_sistemas_ltda, inform_bndes_of_requests).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oracle_do_brasil_sistemas_ltda, maintain_data_operation_registry).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oracle_do_brasil_sistemas_ltda, inform_bndes_data_breach).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, realizar_pagamentos_devidos).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designar_gestor_contrato).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designar_substituto_gestor).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alterar_gestor_contrato).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, fornecer_acesso_codigo_etica).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, colocar_disposicao_informacoes).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comunicar_instrucoes_procedimentos).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comunicar_abertura_procedimento).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, conceder_prazo_para_defesa).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comunicar_aplicacao_penalidade).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, oracle_do_brasil_sistemas_ltda, cede_contract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, oracle_do_brasil_sistemas_ltda, issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, approve_contract_continuity).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, oracle_do_brasil_sistemas_ltda, subcontract_contract_object).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, permission_to_act, oracle_do_brasil_sistemas_ltda, corporate_restructuring).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, oracle_do_brasil_sistemas_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_multa_from_credits).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_renounce_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, right_to_action, oracle_do_brasil_sistemas_ltda, request_reconsideration_or_appeal).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, agree_to_contract_alteration).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, refrain_from_denaturing_contract).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_liable_for_damages).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_vigesima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party_of_breach).
legal_relation_instance(clausula_vigesima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notice).
legal_relation_instance(clausula_vigesima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, allow_opportunity_to_defend).
legal_relation_instance(clausula_vigesima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, consent_to_contract_termination).
legal_relation_instance(clausula_vigesima_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_force_majeure).
legal_relation_instance(clausula_vigesima_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_breach).
legal_relation_instance(clausula_vigesima_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_dissolution).
legal_relation_instance(clausula_vigesima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, release_area_for_execution).
legal_relation_instance(clausula_vigesima_primeira_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigesima_primeira_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_waiver).
legal_relation_instance(clausula_vigesima_primeira_disposicoes_finais, permission_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_enforcement).
legal_relation_instance(clausula_vigesima_segunda_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, resolve_disputes_in_rio).
legal_relation_instance(clausula_vigesima_segunda_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, resolve_disputes_elsewhere).
legal_relation_instance(clausula_nona_matriz_riscos, disability, oracle_do_brasil_sistemas_ltda, cant_sign_additives_due_to_risk_matrix).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, oracle_do_brasil_sistemas_ltda, no_right_to_sign_additives_due_to_risk_matrix).

% --- Action catalog (local to this contract grounding) ---
action_type(adopt_environmental_practices).
action_label(adopt_environmental_practices, 'Adopt environmental practices').
action_type(adopt_good_governance_measures).
action_label(adopt_good_governance_measures, 'Adopt good governance measures').
action_type(agree_to_contract_alteration).
action_label(agree_to_contract_alteration, 'Agree to contract alteration').
action_type(allocate_bndes_employees_relatives).
action_label(allocate_bndes_employees_relatives, 'Omit allocating BNDES employee relatives').
action_type(allow_access_to_central_bank).
action_label(allow_access_to_central_bank, 'Allow access to Central Bank').
action_type(allow_bndes_employee_favoritism).
action_label(allow_bndes_employee_favoritism, 'Omit allowing BNDES employee favoritism').
action_type(allow_opportunity_to_defend).
action_label(allow_opportunity_to_defend, 'Allow defense').
action_type(alterar_gestor_contrato).
action_label(alterar_gestor_contrato, 'Change contract manager').
action_type(analyze_reajustment_revision_request).
action_label(analyze_reajustment_revision_request, 'Analyze reajustment/revision request').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(approve_contract_continuity).
action_label(approve_contract_continuity, 'Approve contract continuation').
action_type(assume_responsibility_for_charges).
action_label(assume_responsibility_for_charges, 'Assume responsibility for charges').
action_type(be_liable_for_damages).
action_label(be_liable_for_damages, 'Be liable for damages').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Subject to penalties').
action_type(bear_costs_quantification_error).
action_label(bear_costs_quantification_error, 'Bear costs of quantification error').
action_type(cant_sign_additives_due_to_risk_matrix).
action_label(cant_sign_additives_due_to_risk_matrix, 'Can\'t sign addenda due to risk matrix').
action_type(cede_contract).
action_label(cede_contract, 'No right to assign contract').
action_type(claim_waiver).
action_label(claim_waiver, 'Claim waiver').
action_type(colocar_disposicao_informacoes).
action_label(colocar_disposicao_informacoes, 'Provide necessary information').
action_type(communicate_impediment_to_contracting).
action_label(communicate_impediment_to_contracting, 'Communicate impediment to contract').
action_type(communicate_interest_in_contract_extension).
action_label(communicate_interest_in_contract_extension, 'Communicate interest in contract extension').
action_type(comunicar_abertura_procedimento).
action_label(comunicar_abertura_procedimento, 'Communicate opening of procedure').
action_type(comunicar_aplicacao_penalidade).
action_label(comunicar_aplicacao_penalidade, 'Communicate application of penalty').
action_type(comunicar_instrucoes_procedimentos).
action_label(comunicar_instrucoes_procedimentos, 'Communicate instructions').
action_type(conceder_prazo_para_defesa).
action_label(conceder_prazo_para_defesa, 'Grant time for defense').
action_type(consent_to_contract_termination).
action_label(consent_to_contract_termination, 'Consent to terminate contract').
action_type(corporate_restructuring).
action_label(corporate_restructuring, 'Allowed to restructure').
action_type(deduct_multa_from_credits).
action_label(deduct_multa_from_credits, 'Deduct multa from credits').
action_type(delete_personal_data).
action_label(delete_personal_data, 'Delete personal data').
action_type(demand_contractual_guarantee).
action_label(demand_contractual_guarantee, 'Demand contractual guarantee').
action_type(demand_indemnification_no_total_demand).
action_label(demand_indemnification_no_total_demand, 'Demand indemnification').
action_type(designar_gestor_contrato).
action_label(designar_gestor_contrato, 'Appoint contract manager').
action_type(designar_substituto_gestor).
action_label(designar_substituto_gestor, 'Appoint substitute manager').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(discount_penalties).
action_label(discount_penalties, 'Discount penalties').
action_type(efetuar_recebimento_objeto).
action_label(efetuar_recebimento_objeto, 'Effect object reception').
action_type(ensure_security_in_access).
action_label(ensure_security_in_access, 'Ensure security in access').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(execute_object_according_specifications).
action_label(execute_object_according_specifications, 'Execute object per specs').
action_type(execute_services_according_to_policy).
action_label(execute_services_according_to_policy, 'Execute services according to policy').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services according to standards').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(extend_guarantee_presentation_period).
action_label(extend_guarantee_presentation_period, 'Extend guarantee period').
action_type(fail_to_provide_contractual_guarantee).
action_label(fail_to_provide_contractual_guarantee, 'Not provide guarantee').
action_type(follow_bndes_instructions).
action_label(follow_bndes_instructions, 'Follow BNDES instructions').
action_type(follow_inspection_instructions).
action_label(follow_inspection_instructions, 'Follow inspection instructions').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(formulate_revision_request).
action_label(formulate_revision_request, 'Formulate revision request').
action_type(fornecer_acesso_codigo_etica).
action_label(fornecer_acesso_codigo_etica, 'Provide access to ethics code').
action_type(guarantee_no_infringement).
action_label(guarantee_no_infringement, 'Guarantee no infringement').
action_type(inform_bndes_data_breach).
action_label(inform_bndes_data_breach, 'Inform BNDES about data breach').
action_type(inform_bndes_of_requests).
action_label(inform_bndes_of_requests, 'Inform BNDES of requests').
action_type(inform_employees_data_clauses).
action_label(inform_employees_data_clauses, 'Inform employees about data clauses').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'Initiate price revision').
action_type(issue_credit_title).
action_label(issue_credit_title, 'No right to issue credit title').
action_type(issue_instructions_data_treatment).
action_label(issue_instructions_data_treatment, 'Issue instructions for data treatment').
action_type(know_bndes_ethics_policy).
action_label(know_bndes_ethics_policy, 'Know BNDES Ethics Policy').
action_type(know_bndes_information_security_policies).
action_label(know_bndes_information_security_policies, 'Know BNDES information security policies').
action_type(limit_access_to_information).
action_label(limit_access_to_information, 'Limit access to information').
action_type(maintain_conditions_of_qualification).
action_label(maintain_conditions_of_qualification, 'Maintain qualification conditions').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_data_confidentiality).
action_label(maintain_data_confidentiality, 'Maintain data confidentiality').
action_type(maintain_data_operation_registry).
action_label(maintain_data_operation_registry, 'Maintain data operation registry').
action_type(make_payment).
action_label(make_payment, 'Make payment').
action_type(negotiate_price_reduction).
action_label(negotiate_price_reduction, 'Negotiate price reduction').
action_type(no_right_to_sign_additives_due_to_risk_matrix).
action_label(no_right_to_sign_additives_due_to_risk_matrix, 'No right to sign addenda due to risk matrix').
action_type(not_access_confidential_information).
action_label(not_access_confidential_information, 'Do not access confidential information').
action_type(not_copy_reproduce_or_retain_info).
action_label(not_copy_reproduce_or_retain_info, 'Do not copy/reproduce/retain info').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_renounce_penalties).
action_label(not_renounce_penalties, 'Not renounce penalties').
action_type(not_use_confidential_info_after_contract).
action_label(not_use_confidential_info_after_contract, 'Do not use confidential info').
action_type(notify_entity_of_contract_extension).
action_label(notify_entity_of_contract_extension, 'Notify entity of extension').
action_type(notify_government_investigation).
action_label(notify_government_investigation, 'Notify government investigation').
action_type(notify_other_party_of_breach).
action_label(notify_other_party_of_breach, 'Notify breach').
action_type(observe_confidentiality_term).
action_label(observe_confidentiality_term, 'Observe confidentiality term').
action_type(offer_undue_advantage).
action_label(offer_undue_advantage, 'Omit offering undue advantage').
action_type(omit_charging_interest_when_contracted_party_fault).
action_label(omit_charging_interest_when_contracted_party_fault, 'Omit interest when party fault').
action_type(omit_enforcement).
action_label(omit_enforcement, 'Omit enforcement').
action_type(pay_all_taxes_and_fees).
action_label(pay_all_taxes_and_fees, 'Pay taxes and fees').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay contracted party').
action_type(payment_reduction_partial_execution).
action_label(payment_reduction_partial_execution, 'Accept reduced payment').
action_type(permit_fiscalization_and_monitoring).
action_label(permit_fiscalization_and_monitoring, 'Permit fiscalization').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_manifestation_on_contract_extension).
action_label(present_manifestation_on_contract_extension, 'Present manifestation on contract extension').
action_type(prevent_allocation_of_bndes_employees_relatives).
action_label(prevent_allocation_of_bndes_employees_relatives, 'Prevent allocation of BNDES employee relatives').
action_type(prevent_bndes_employee_favoritism).
action_label(prevent_bndes_employee_favoritism, 'Prevent BNDES employee favoritism').
action_type(prove_exclusion_from_simples_nacional).
action_label(prove_exclusion_from_simples_nacional, 'Prove exclusion from Simples Nacional').
action_type(prove_triggering_event).
action_label(prove_triggering_event, 'Prove triggering event').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_data_access_system).
action_label(provide_data_access_system, 'Provide data access system').
action_type(provide_requested_information).
action_label(provide_requested_information, 'Provide requested information').
action_type(provide_tax_exemption_proof).
action_label(provide_tax_exemption_proof, 'Provide tax exemption proof').
action_type(provide_technical_support).
action_label(provide_technical_support, 'Provide technical support').
action_type(provide_written_notice).
action_label(provide_written_notice, 'Provide written notice').
action_type(realizar_pagamentos_devidos).
action_label(realizar_pagamentos_devidos, 'Make payments').
action_type(receber_objeto).
action_label(receber_objeto, 'Receive object').
action_type(receive_contract_object).
action_label(receive_contract_object, 'Receive contract object').
action_type(receive_fiscalization_and_monitoring).
action_label(receive_fiscalization_and_monitoring, 'Receive fiscalization').
action_type(receive_object_according_specifications).
action_label(receive_object_according_specifications, 'Receive object per specs').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments).
action_label(receive_payments, 'Receive payments').
action_type(receive_technical_support).
action_label(receive_technical_support, 'Receive technical support').
action_type(refrain_from_denaturing_contract).
action_label(refrain_from_denaturing_contract, 'Refrain from denaturing contract').
action_type(regress_against_contracted_party).
action_label(regress_against_contracted_party, 'Regress against contracted party').
action_type(reject_late_document).
action_label(reject_late_document, 'Reject late document').
action_type(release_area_for_execution).
action_label(release_area_for_execution, 'Release area').
action_type(remove_agents_from_contract_execution).
action_label(remove_agents_from_contract_execution, 'Remove agents from contract execution').
action_type(repair_correct_remove_replace_object).
action_label(repair_correct_remove_replace_object, 'Repair/correct/remove/replace object').
action_type(repair_damages_to_bndes_or_third_parties).
action_label(repair_damages_to_bndes_or_third_parties, 'Repair damages to BNDES/third parties').
action_type(report_conflict_of_interest).
action_label(report_conflict_of_interest, 'Report conflict of interest').
action_type(report_security_breaches).
action_label(report_security_breaches, 'Report security breaches').
action_type(request_additional_data).
action_label(request_additional_data, 'Request additional data').
action_type(request_price_adjustment).
action_label(request_price_adjustment, 'Request price adjustment').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_reajustment_or_revision).
action_label(request_reajustment_or_revision, 'Request reajustment or revision').
action_type(request_reconsideration_or_appeal).
action_label(request_reconsideration_or_appeal, 'Request reconsideration/appeal').
action_type(resolve_disputes_elsewhere).
action_label(resolve_disputes_elsewhere, 'Resolve disputes elsewhere').
action_type(resolve_disputes_in_rio).
action_label(resolve_disputes_in_rio, 'Resolve disputes in Rio').
action_type(return_bndes_property).
action_label(return_bndes_property, 'Return BNDES property').
action_type(return_resources_and_revoke_profiles).
action_label(return_resources_and_revoke_profiles, 'Return resources/revoke profiles').
action_type(send_documents).
action_label(send_documents, 'Send Documents').
action_type(share_data_without_authorization).
action_label(share_data_without_authorization, 'Do not share data without authorization').
action_type(subcontract_contract_object).
action_label(subcontract_contract_object, 'No right to subcontract').
action_type(subjection_to_penalties).
action_label(subjection_to_penalties, 'Subjection to penalties').
action_type(terminate_contract_due_to_breach).
action_label(terminate_contract_due_to_breach, 'Terminate contract for breach').
action_type(terminate_contract_due_to_dissolution).
action_label(terminate_contract_due_to_dissolution, 'Terminate due to dissolution').
action_type(terminate_contract_due_to_force_majeure).
action_label(terminate_contract_due_to_force_majeure, 'Terminate due to force majeure').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_278_2023).
contract_metadata(contrato_ocs_278_2023, numero_ocs, '278/2023').
contract_metadata(contrato_ocs_278_2023, numero_sap, '4400005628').
contract_metadata(contrato_ocs_278_2023, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_278_2023, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'ORACLE DO BRASIL SISTEMAS LTDA']).
contract_metadata(contrato_ocs_278_2023, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_278_2023, contratado, 'ORACLE DO BRASIL SISTEMAS LTDA').
contract_metadata(contrato_ocs_278_2023, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_278_2023, cnpj_contratado, '59.456.277/0001-76').
contract_metadata(contrato_ocs_278_2023, data_autorizacao, '23/10/2023').
contract_metadata(contrato_ocs_278_2023, ip_ati_degat, '11/2023').
contract_metadata(contrato_ocs_278_2023, data_ip_ati_degat, '11/10/2023').
contract_metadata(contrato_ocs_278_2023, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_278_2023, centro_custo, 'BN000040000').
contract_metadata(contrato_ocs_278_2023, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_278_2023, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_278_2023, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação de serviços de suporte técnico com direito de atualização de versão de software para o Sistema Gerenciador de Banco de Dados (SGBD) composto pelos programas Oracle Database Enterprise Edition, Oracle Diagnostics Pack, Oracle Partitioning, Oracle Real Application Cluster e Oracle Tuning Pack na modalidade Premier Support, incluindo os serviços do Oracle Priority Support, conforme especificações constantes do Termo de Referência e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.  Parágrafo Primeiro Em caso de divergência entre os termos deste Contrato e do Termo de Referência, as disposições do Contrato prevalecerão sobre as disposições do Termo de Referência.').
contract_clause(contrato_ocs_278_2023, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 24 (vinte e quatro) meses, a contar da data de sua assinatura ou de 26/10/2023, o que ocorrer por último, podendo ser prorrogado, mediante aditivo até o limite total de 60 (sessenta) meses.  Parágrafo Primeiro O CONTRATADO deverá, no prazo de até 5 (cinco) dias úteis, contados da notificação do Gestor do Contrato, apresentar, por intermédio do seu Representante Legal, sua manifestação sobre a prorrogação do Contrato.  Parágrafo Segundo Independente da notificação do parágrafo anterior, o CONTRATADO deverá comunicar ao Gestor seu interesse quanto à prorrogação do contrato até 90 (noventa) dias antes do término de cada período de vigência contratual.  Parágrafo Terceiro A formalização da prorrogação será efetuada por meio de aditivo epistolar.   Parágrafo Quarto Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_278_2023, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_278_2023, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com a Política de Suporte do CONTRATADO e com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará na aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_278_2023, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_278_2023, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 11.562.493,02 (onze milhões, quinhentos e sessenta e dois mil, quatrocentos e noventa e três reais e dois centavos, conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_278_2023, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte da prestação do serviço/fornecimento do bem.   Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quarto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quinto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF; e XIV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Sexto Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Sétimo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Oitavo O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Nono Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;  Parágrafo Décimo  Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_278_2023, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado da data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do ICTI acumulado, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_278_2023, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_278_2023, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL', 'O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 578.124,65 (quinhentos e setenta e oito mil, cento e vinte e quatro reais e sessenta e cinco centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.   Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.  Parágrafo Quinto A garantia contratual deverá cobrir: I. todas as obrigações decorrentes do objeto contratual, assim como eventuais danos decorrentes de seu descumprimento; II. todas as obrigações relacionadas ao objeto principal, ainda que decorrentes de sua manutenção e/ou refazimento, bem como das medidas necessárias à prevenção ordinária de sinistros, prejuízos e danos em geral; III. prejuízos decorrentes de atos de corrupção praticados sem participação dolosa do BNDES ou de seus representantes; IV. prejuízos diretos causados ao BNDES decorrentes de culpa ou dolo durante a execução do Contrato; V. multas moratórias e/ou punitivas aplicadas pelo BNDES ao CONTRATADO;  VI. obrigações trabalhistas e previdenciárias de qualquer natureza, não adimplidas pelo CONTRATADO, quando o objeto contratual demandar cessão de mão de obra com dedicação exclusiva.  Parágrafo Sexto Em caso de prorrogação da vigência ou alteração do objeto contratual, o CONTRATADO deverá notificar a entidade fiadora/seguradora, conforme o caso, no prazo de até 10 (dez) dias úteis, contados da formalização do respectivo Instrumento Contratual.  Parágrafo Sétimo Por se tratar de garantia contratual prestada em benefício de uma Estatal, caso os documentos de caução, fiança ou seguro façam referência à Lei nº 8.666/1993 e/ou à Lei nº 14.133/2021, aplicam-se as disposições respectivas da Lei nº 13.303/2016, no que couber.').
contract_clause(contrato_ocs_278_2023, clausula_decima_primeira_obrigações_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados, nos termos da proposta comercial do CONTRATADO; IV. reparar todos os danos causados diretamente ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir fiscalizações e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. Para fins de fiscalização, seguir as instruções e aos procedimentos de fiscalização estabelecidos pelo BNDES, para a adequada execução do objeto contratado de acordo com as especificações do Contrato e da proposta comercial; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento, exceto para assuntos de caráter técnico; XI. Além das obrigações usualmente aplicadas à Contratada, permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados sob este contrato, bem como acesso ao local da prestação de serviço, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017 XI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal;  XII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo, observados os termos da proposta da CONTRATADA;  XIII.  responsabilizar-se pelo cumprimento dos aspectos de segurança no acesso às dependências do BNDES por parte dos profissionais alocados na execução dos serviços, no que concerne ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XIV. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência deste Contrato;').
contract_clause(contrato_ocs_278_2023, clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. conhecer a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política Corporativa de Integridade do Sistema BNDES, sendo que a CONTRATADA se vincula ao seu próprio Código de Ética;  V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição;  VI. informar sempre que solicitado pelo BNDES a ocorrência de potencial situação de conflito de interesses entre os colaboradores do CONTRATADO diretamente relacionados à prestação de serviços objeto do presente instrumento e o BNDES, comunicando na mesma oportunidade as medidas que serão adotadas para o tratamento da questão; e VII. notificar em tempo razoável o BNDES sobre justificada investigação ou procedimento iniciado por autoridade governamental relacionado à violação de Leis Anticorrupção (nacional ou estrangeira) e/ou de obrigações da empresa, de seus administradores, diretores, prepostos, empregados, , referentes a este Contrato.    Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política Corporativa de Integridade do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307). As irregularidades ou descumprimentos da legislação vigente aplicável também poderá ser reportada para o canal de denúncias do CONTRATADO, conforme o disposto em seu Código de Ética e Conduta Profissional disponibilizado no seguinte link https://www.oracle.com/webfolder/assets/ebook/employee-code-of-conduct-and-ethics/pdf/PT.pdf , bem como por email no seguinte endereço: lad-compliance-appr_ww@oracle.com.').
contract_clause(contrato_ocs_278_2023, clausula_decima_terceira_sigilo_das_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão pelo prazo de 10 (dez) anos após a cessação do vínculo contratual e da prestação dos serviços: I. conhecer as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações, observando a CONTRATADA as suas próprias políticas de segurança de informação;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, desde que identificadas como tal no momento de sua divulgaçaãp, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e informar em menor prazo possível ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo IV (Termo de Confidencialidade para Representante Legal) deste Contrato.').
contract_clause(contrato_ocs_278_2023, clausula_decima_quarta_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA QUARTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes, sendo o Contratante eventual contratolador e o Contratado eventual operador de dados pessoais, assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas de boa governança sob o aspecto técnico, jurídico e administrativo, inclusive de segurança, e observar que:    I.Eventual tratamento de dados pessoais em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados Pessoais - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II.O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais diretamente pelo CONTRATADO, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida;  III.O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais;  IV.No caso de tratamento de dados pessoais realizado pelo CONTRATADO para cumprimento de suas obrigações legais ou para atendimento de suas próprias finalidades, o BNDES não será considerado “Controlador de Dados Pessoais” e, sim, o CONTRATADO;  V.Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto;  VI.O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos;  VII.Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação.   VIII.O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados.  IX.O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais;  X.O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais.  XI.O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas.  XII.O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais.  XIII.Qualquer incidente ao qual o CONTRATADO tiver dado causa e que implique em violação ou vazamento de dados pessoais deverá ser comunicado em prazo não superior a 24 horas ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada.  XIV.Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Cada uma das Partes será controladora independente, para os fins desse CONTRATO, cabendo definir individualmente as bases legais apropriadas e diretrizes para as operações de tratamento, em relação aos seguintes dados pessoais: (i) que vierem a coletar diretamente junto aos respectivos titulares, desde que essa operação de tratamento se dê com base em suas próprias decisões; (ii) oriundos de suas próprias bases de dados; e (iii) relativos ao seu corpo de colaboradores, funcionários e/ou prepostos envolvidos para a regular execução deste Contrato.  Parágrafo Terceiro Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste Contrato.  Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal. Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei nº 13.709/2018 (Lei Geral de Proteção de Dados Pessoais - LGPD), bem como informar aos titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.  Parágrafo Sétimo A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e se dará exclusicamente para fins de execução do objeto contrato e entre empresas do mesmo grupo.').
contract_clause(contrato_ocs_278_2023, clausula_decima_quinta_obrigacoes_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Alexandre Goes Zattar, que atualmente exerce a função de coordenador de serviços a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, como substituto do Gestor do Contrato, Antony Seabra de Medeiros, para atuar em sua eventual ausência;  IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso ao Código de Ética do Sistema BNDES, da Política Corporativa de Integridade do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VI. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_278_2023, clausula_decima_sexta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SEXTA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, exploração irregular, ilegal ou criminosa do trabalho infantil ou prática relacionada ao trabalho em condições análogas à escravidão, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.   Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.  Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.')
contract_clause(contrato_ocs_278_2023, clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA SÉTIMA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO  É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES quanto à continuidade deste contrato, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais, previstos no Termo de Referência.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo. Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES quanto à continuidade deste contrato, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais, previstos no Termo de Referência. Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes. Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_278_2023, clausula_decima_oitava_penalidades, 'CLÁUSULA DÉCIMA OITAVA – PENALIDADES Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e danos diretos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, sob esta contratação, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos. Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.  Parágrafo Nono As multas e demais penalidades previstas neste Contrato são independentes entre si, podendo ser aplicadas isoladamente ou cumulativamente, sendo que não deverão ultrapassar em sua totalidade o limite máximo de 20% (vinte por cento) do valor global do Contrato.', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração. Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES. Parágrafo Segundo Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES. Parágrafo Terceiro A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato. Parágrafo Quarto A multa poderá ser aplicada juntamente com as demais penalidades. Parágrafo Quinto A multa aplicada ao CONTRATADO e danos diretos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, sob esta contratação, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos. Parágrafo Sexto No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013. Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência). Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados. Parágrafo Nono As multas e demais penalidades previstas neste Contrato são independentes entre si, podendo ser aplicadas isoladamente ou cumulativamente, sendo que não deverão ultrapassar em sua totalidade o limite máximo de 20% (vinte por cento) do valor global do Contrato.').
contract_clause(contrato_ocs_278_2023, clausula_decima_nona_alteracoes_contratuais, 'CLÁUSULA DÉCIMA NONA – ALTERAÇÕES CONTRATUAIS  O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.    Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato). Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar. Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente. Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_278_2023, clausula_vigesima_extincao_contrato, 'CLÁUSULA VIGÉSIMA – EXTINÇÃO DO CONTRATO O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução do CONTRATADO;  XII. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.   Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal; VIII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução do CONTRATADO; XII. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato. Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias. Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_278_2023, clausula_vigesima_primeira_disposicoes_finais, 'CLÁUSULA VIGÉSIMA PRIMEIRA – DISPOSIÇÕES FINAIS Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência  Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto. Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_278_2023, clausula_vigesima_segunda_foro, 'CLÁUSULA VIGÉSIMA SEGUNDA – FORO  É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As partes consideram, para todos os efeitos, a data da última assinatura digital como a data de formalização jurídica deste instrumento.  As folhas deste contrato foram conferidas por Ana Paula Soeiro de Britto, advogada do BNDES, por autorização do representante legal que o assina.   _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES    _____________________________________________________________________ ORACLE DO BRASIL SISTEMAS LTDA   Testemunhas  __________________________________   __________________________________', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja. As partes consideram, para todos os efeitos, a data da última assinatura digital como a data de formalização jurídica deste instrumento. As folhas deste contrato foram conferidas por Ana Paula Soeiro de Britto, advogada do BNDES, por autorização do representante legal que o assina. _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES _____________________________________________________________________ ORACLE DO BRASIL SISTEMAS LTDA Testemunhas __________________________________ __________________________________').

% ===== END =====
