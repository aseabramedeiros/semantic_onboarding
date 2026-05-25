% ===== KOA Combined Output | contract_id: contrato_ocs_338_2022 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_338_2022_-_RTM_(SISBACEN).pl
% contract_id: contrato_ocs_338_2022

instance_of(contrato_ocs_338_2022, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_338_2022).
plays_role(rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, hired_service_provider_role, contrato_ocs_338_2022).

clause_of(clausula_primeira_objeto, contrato_ocs_338_2022).
clause_of(clausula_segunda_vigencia, contrato_ocs_338_2022).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_338_2022).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_338_2022).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_338_2022).
clause_of(clausula_sexta_preco, contrato_ocs_338_2022).
clause_of(clausula_setima_pagamento, contrato_ocs_338_2022).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_338_2022).
clause_of(clausula_decima_obrigações_contratado, contrato_ocs_338_2022).
clause_of(clausula_decima_primeira_conduta_etica, contrato_ocs_338_2022).
clause_of(clausula_decima_segunda_sigilo, contrato_ocs_338_2022).
clause_of(clausula_decima_terceira_acesso_protecao_dados_pessoais, contrato_ocs_338_2022).
clause_of(clausula_decima_quarta_obrigações_bndes, contrato_ocs_338_2022).
clause_of(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, contrato_ocs_338_2022).
clause_of(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, contrato_ocs_338_2022).
clause_of(clausula_decima_setima_penalidades, contrato_ocs_338_2022).
clause_of(clausula_decima_oitava_alteracoes_contratuais, contrato_ocs_338_2022).
clause_of(clausula_decima_nona_extincao_contrato, contrato_ocs_338_2022).
clause_of(clausula_vigésima_disposicoes_finais, contrato_ocs_338_2022).
clause_of(clausula_vigésima_primeira_foro, contrato_ocs_338_2022).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_338_2022).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, provide_sisbacen_access_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_sisbacen_access_services).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, provide_service).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, implement_service).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_service).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_implementation).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, execute_contract_object).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_executed_object).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, be_subject_to_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, require_service_execution_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_receipt_of_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, demand_indemnization).
legal_relation_instance(clausula_sexta_preco, subjection, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, price_reduction_partial_execution).
legal_relation_instance(clausula_sexta_preco, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, bear_cost_quantity_error).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, efetuar_pagamento).
legal_relation_instance(clausula_setima_pagamento, right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, apresentar_documento_fiscal).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_invoice).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduzir_valor).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, fornecer_documentos_comprobatorios).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, request_price_readjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, negotiate_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, present_information_for_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, request_price_readjustment_revision_before_contract_end).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_readjustment_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, no_right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, request_readjustment_revision_after_deadline).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, request_price_readjustment).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, communicate_penalty_imposition).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, repair_defects).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, repair_damages).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, pay_taxes).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, assume_fiscal_responsibility).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, provide_tax_exclusion_proof).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, allow_inspections).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, obey_instructions).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, appoint_representative).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, not_offer_advantage).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_omit, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, omit_offering_advantage).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, remove_agents).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, communicate_situation_to_bndes).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, prevent_corruption).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, prevent_favored_participation).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, ensure_ethical_behavior).
legal_relation_instance(clausula_decima_primeira_conduta_etica, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, adopt_sustainable_practices).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, comply_with_bndes_information_security_policy).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_omit, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, not_access_confidential_information).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, maintain_confidentiality_of_information).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, limit_access_to_information).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, inform_bndes_of_violations).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, return_bndes_property).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_omit, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, not_use_confidential_information).
legal_relation_instance(clausula_decima_segunda_sigilo, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, observe_confidentiality_term).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, protect_privacy_rights).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, adopt_security_measures).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, follow_bndes_instructions).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, maintain_data_confidentiality).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, inform_bndes_of_requests).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, maintain_data_operation_records).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, communicate_data_incidents).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, delete_personal_data_at_end).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_of_regress).
legal_relation_instance(clausula_decima_terceira_acesso_protecao_dados_pessoais, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, provide_data_access_channel).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_auditor).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_receiving_committee).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_access_to_ethics_code).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_investigation_start).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty_application).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_information_for_service_execution).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract_manager).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, comprovar_ausencia_sancao).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, solicitar_comprovacao_ausencia_sancao).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspender_execucao_contratual).
legal_relation_instance(clausula_decima_quinta_equidade_genero_valorizacao_diversidade, disability, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, nao_impedir_suspensao_contratual).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, no_right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, assign_contract).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, no_right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, assign_credit).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, no_right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, issue_credit_title).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_contractual_risks).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, no_right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, subcontract_object).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, request_bndes_acquiescence).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, maintain_contract_conditions).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, execute_contract).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, receive_credits).
legal_relation_instance(clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, permission_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, merge_split_incorporate).
legal_relation_instance(clausula_decima_setima_penalidades, subjection, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credits).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extinguish_contract).
legal_relation_instance(clausula_decima_setima_penalidades, subjection, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, credits_subject_to_deduction).
legal_relation_instance(clausula_decima_setima_penalidades, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, observe_law_12846).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_formalization_contract_alteration).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages_refusal_alteration).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bear_damages_refusal_alteration).
legal_relation_instance(clausula_decima_nona_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extinguish_contract_consensually).
legal_relation_instance(clausula_decima_nona_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notice_of_termination).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_for_breach).
legal_relation_instance(clausula_decima_nona_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notice_of_breach).
legal_relation_instance(clausula_decima_nona_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_after_suspension).
legal_relation_instance(clausula_decima_nona_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notification_of_termination).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_fortuitous_event).
legal_relation_instance(clausula_decima_nona_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_for_defence).
legal_relation_instance(clausula_vigésima_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights_at_any_time).
legal_relation_instance(clausula_vigésima_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_strict_compliance).
legal_relation_instance(clausula_vigésima_primeira_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_rio_de_janeiro_court).
legal_relation_instance(clausula_vigésima_primeira_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, litigate_in_other_court).
legal_relation_instance(clausula_vigésima_primeira_foro, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, verify_contract_signatures).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, claim_for_allocated_risks).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, respect_economic_financial_balance).
legal_relation_instance(clausula_nona_matriz_riscos, subjection, rtm_rede_de_telecomunicacoes_para_o_mercado_ltda, undergo_economic_financial_balance).

% --- Action catalog (local to this contract grounding) ---
action_type(adopt_security_measures).
action_label(adopt_security_measures, 'Adopt security measures').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(allow_central_bank_access).
action_label(allow_central_bank_access, 'Allow Central Bank Access').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_contract_manager).
action_label(alter_contract_manager, 'Alter contract manager').
action_type(analyze_contractual_risks).
action_label(analyze_contractual_risks, 'Power to analyze risks').
action_type(analyze_readjustment_revision_request).
action_label(analyze_readjustment_revision_request, 'Analyze readjustment/revision request').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction).
action_label(apply_price_reduction, 'Apply price reduction').
action_type(appoint_representative).
action_label(appoint_representative, 'Appoint representative').
action_type(apresentar_documento_fiscal).
action_label(apresentar_documento_fiscal, 'Present invoice').
action_type(assign_contract).
action_label(assign_contract, 'No right to assign contract').
action_type(assign_credit).
action_label(assign_credit, 'No right to assign credit').
action_type(assume_fiscal_responsibility).
action_label(assume_fiscal_responsibility, 'Assume fiscal responsibility').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Subject to penalties').
action_type(be_subject_to_price_reduction).
action_label(be_subject_to_price_reduction, 'Subject to price reduction').
action_type(bear_cost_quantity_error).
action_label(bear_cost_quantity_error, 'Bear cost of quantity errors').
action_type(bear_damages_refusal_alteration).
action_label(bear_damages_refusal_alteration, 'Bear damages from refusal').
action_type(choose_rio_de_janeiro_court).
action_label(choose_rio_de_janeiro_court, 'Choose Rio de Janeiro court').
action_type(claim_for_allocated_risks).
action_label(claim_for_allocated_risks, 'No right to claim for risks').
action_type(communicate_data_incidents).
action_label(communicate_data_incidents, 'Communicate data incidents').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_investigation_start).
action_label(communicate_investigation_start, 'Communicate investigation start').
action_type(communicate_penalty_application).
action_label(communicate_penalty_application, 'Communicate penalty application').
action_type(communicate_penalty_imposition).
action_label(communicate_penalty_imposition, 'Communicate penalty').
action_type(communicate_situation_to_bndes).
action_label(communicate_situation_to_bndes, 'Communicate situation to BNDES').
action_type(compensate_damages_refusal_alteration).
action_label(compensate_damages_refusal_alteration, 'Compensate damages for refusal').
action_type(comply_with_bndes_information_security_policy).
action_label(comply_with_bndes_information_security_policy, 'Comply with security policy').
action_type(comprovar_ausencia_sancao).
action_label(comprovar_ausencia_sancao, 'Prove no sanction').
action_type(credits_subject_to_deduction).
action_label(credits_subject_to_deduction, 'Credits subject to deduction').
action_type(deduct_credits).
action_label(deduct_credits, 'Deduct credits').
action_type(deduzir_valor).
action_label(deduzir_valor, 'Deduct amount').
action_type(delete_personal_data_at_end).
action_label(delete_personal_data_at_end, 'Delete personal data at end').
action_type(demand_indemnization).
action_label(demand_indemnization, 'No right to demand indemnization').
action_type(demand_tax_proof).
action_label(demand_tax_proof, 'Demand tax proof').
action_type(designate_contract_auditor).
action_label(designate_contract_auditor, 'Designate contract auditor').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_receiving_committee).
action_label(designate_receiving_committee, 'Designate receiving committee').
action_type(efetuar_pagamento).
action_label(efetuar_pagamento, 'Make payment').
action_type(effect_receipt_of_object).
action_label(effect_receipt_of_object, 'Effect receipt of object').
action_type(ensure_ethical_behavior).
action_label(ensure_ethical_behavior, 'Ensure ethical behavior').
action_type(execute_contract).
action_label(execute_contract, 'Duty to execute contract').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contracted object').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services according to standards').
action_type(exercise_rights_at_any_time).
action_label(exercise_rights_at_any_time, 'Exercise rights at any time').
action_type(extinguish_contract).
action_label(extinguish_contract, 'Extinguish contract').
action_type(extinguish_contract_consensually).
action_label(extinguish_contract_consensually, 'Extinguish contract consensually').
action_type(follow_bndes_instructions).
action_label(follow_bndes_instructions, 'Follow BNDES instructions').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(fornecer_documentos_comprobatorios).
action_label(fornecer_documentos_comprobatorios, 'Provide supporting documents').
action_type(implement_service).
action_label(implement_service, 'Implement service within 3 months').
action_type(inform_bndes_of_requests).
action_label(inform_bndes_of_requests, 'Inform BNDES of requests').
action_type(inform_bndes_of_violations).
action_label(inform_bndes_of_violations, 'Inform BNDES of violations').
action_type(inform_representative_data).
action_label(inform_representative_data, 'Inform representative data').
action_type(issue_credit_title).
action_label(issue_credit_title, 'No right to issue credit title').
action_type(limit_access_to_information).
action_label(limit_access_to_information, 'Limit access to information').
action_type(litigate_in_other_court).
action_label(litigate_in_other_court, 'Litigate in other court').
action_type(maintain_confidentiality_of_information).
action_label(maintain_confidentiality_of_information, 'Maintain confidentiality').
action_type(maintain_contract_conditions).
action_label(maintain_contract_conditions, 'Duty to maintain conditions').
action_type(maintain_data_confidentiality).
action_label(maintain_data_confidentiality, 'Maintain data confidentiality').
action_type(maintain_data_operation_records).
action_label(maintain_data_operation_records, 'Maintain data operation records').
action_type(maintain_escalation_list).
action_label(maintain_escalation_list, 'Maintain escalation list').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(make_payments).
action_label(make_payments, 'Make payments').
action_type(merge_split_incorporate).
action_label(merge_split_incorporate, 'Permitted to merge, split, or incorporate').
action_type(nao_impedir_suspensao_contratual).
action_label(nao_impedir_suspensao_contratual, 'Cannot prevent contract suspension').
action_type(negotiate_price_reduction).
action_label(negotiate_price_reduction, 'Negotiate price reduction').
action_type(not_access_confidential_information).
action_label(not_access_confidential_information, 'Do not access confidential info').
action_type(not_offer_advantage).
action_label(not_offer_advantage, 'Not offer undue advantage').
action_type(not_reverse_compile).
action_label(not_reverse_compile, 'Not reverse compile').
action_type(not_use_confidential_information).
action_label(not_use_confidential_information, 'Not use confidential information').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_confidentiality_term).
action_label(observe_confidentiality_term, 'Observe confidentiality term').
action_type(observe_law_12846).
action_label(observe_law_12846, 'Observe law 12.846').
action_type(omit_formalization_contract_alteration).
action_label(omit_formalization_contract_alteration, 'Omit formalization of contract alteration').
action_type(omit_offering_advantage).
action_label(omit_offering_advantage, 'Omit offering advantage').
action_type(omit_strict_compliance).
action_label(omit_strict_compliance, 'No right to require strict compliance').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay the contracted party').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(present_information_for_price_reduction).
action_label(present_information_for_price_reduction, 'Present information for price reduction').
action_type(prevent_corruption).
action_label(prevent_corruption, 'Prevent corruption').
action_type(prevent_favored_participation).
action_label(prevent_favored_participation, 'Prevent favored participation').
action_type(price_reduction_partial_execution).
action_label(price_reduction_partial_execution, 'Subject to price reduction for partial execution').
action_type(protect_privacy_rights).
action_label(protect_privacy_rights, 'Protect privacy rights').
action_type(provide_access_to_ethics_code).
action_label(provide_access_to_ethics_code, 'Provide access to ethics code').
action_type(provide_address).
action_label(provide_address, 'Provide address').
action_type(provide_data_access_channel).
action_label(provide_data_access_channel, 'Provide data access channel').
action_type(provide_information_for_service_execution).
action_label(provide_information_for_service_execution, 'Provide information').
action_type(provide_opportunity_for_defence).
action_label(provide_opportunity_for_defence, 'Opportunity to defend').
action_type(provide_required_information).
action_label(provide_required_information, 'Provide Required Info').
action_type(provide_service).
action_label(provide_service, 'Provide service for 60 months').
action_type(provide_sisbacen_access_services).
action_label(provide_sisbacen_access_services, 'Provide SISBACEN access services').
action_type(provide_tax_exclusion_proof).
action_label(provide_tax_exclusion_proof, 'Provide tax exclusion proof').
action_type(provide_written_notice_of_breach).
action_label(provide_written_notice_of_breach, 'Provide breach notice').
action_type(provide_written_notice_of_termination).
action_label(provide_written_notice_of_termination, 'Provide written notice').
action_type(provide_written_notification_of_termination).
action_label(provide_written_notification_of_termination, 'Provide termination notice').
action_type(receive_credits).
action_label(receive_credits, 'Right to receive credits').
action_type(receive_executed_object).
action_label(receive_executed_object, 'Receive executed object').
action_type(receive_implementation).
action_label(receive_implementation, 'Receive service implementation').
action_type(receive_object).
action_label(receive_object, 'Receive object').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_service).
action_label(receive_service, 'Receive continued service').
action_type(receive_sisbacen_access_services).
action_label(receive_sisbacen_access_services, 'Receive SISBACEN access services').
action_type(reject_invoice).
action_label(reject_invoice, 'Reject invoice').
action_type(remove_agents).
action_label(remove_agents, 'Remove agents').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_defects).
action_label(repair_defects, 'Repair defects').
action_type(request_bndes_acquiescence).
action_label(request_bndes_acquiescence, 'Duty to request BNDES approval').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'Request price readjustment').
action_type(request_price_readjustment_revision_before_contract_end).
action_label(request_price_readjustment_revision_before_contract_end, 'Request readjustment/revision before contract end').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_proof_of_qualification).
action_label(request_proof_of_qualification, 'Request proof of qualification').
action_type(request_readjustment_revision_after_deadline).
action_label(request_readjustment_revision_after_deadline, 'Cannot request readjustment/revision after deadline').
action_type(require_additional_data).
action_label(require_additional_data, 'Require additional data').
action_type(require_service_execution_according_to_standards).
action_label(require_service_execution_according_to_standards, 'Require service execution').
action_type(respect_economic_financial_balance).
action_label(respect_economic_financial_balance, 'Respect economic-financial balance').
action_type(return_bndes_property).
action_label(return_bndes_property, 'Return BNDES property').
action_type(return_documents).
action_label(return_documents, 'Return documents').
action_type(right_of_regress).
action_label(right_of_regress, 'Right of regress').
action_type(solicitar_comprovacao_ausencia_sancao).
action_label(solicitar_comprovacao_ausencia_sancao, 'Request proof no sanction').
action_type(subcontract_object).
action_label(subcontract_object, 'No right to subcontract').
action_type(submit_dif).
action_label(submit_dif, 'Submit DIF').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(suspender_execucao_contratual).
action_label(suspender_execucao_contratual, 'Suspend contract execution').
action_type(terminate_contract_after_suspension).
action_label(terminate_contract_after_suspension, 'Terminate after suspension').
action_type(terminate_contract_due_to_fortuitous_event).
action_label(terminate_contract_due_to_fortuitous_event, 'Terminate due to event').
action_type(terminate_contract_for_breach).
action_label(terminate_contract_for_breach, 'Terminate for breach').
action_type(undergo_economic_financial_balance).
action_label(undergo_economic_financial_balance, 'Subject to economic-financial balance').
action_type(use_collected_data).
action_label(use_collected_data, 'Use collected data').
action_type(verify_contract_signatures).
action_label(verify_contract_signatures, 'Verify contract signatures').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_338_2022).
contract_metadata(contrato_ocs_338_2022, numero_ocs, '338/2022').
contract_metadata(contrato_ocs_338_2022, numero_sap, '4400005296').
contract_metadata(contrato_ocs_338_2022, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_338_2022, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'RTM - REDE DE TELECOMUNICACOES PARA O MERCADO LTDA']).
contract_metadata(contrato_ocs_338_2022, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_338_2022, contratado, 'RTM - REDE DE TELECOMUNICACOES PARA O MERCADO LTDA').
contract_metadata(contrato_ocs_338_2022, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_338_2022, cnpj_contratado, '03.341.541/0001-71').
contract_metadata(contrato_ocs_338_2022, procedimento_licitatorio, 'Pregão Eletrônico nº 41/2022 - BNDES').
contract_metadata(contrato_ocs_338_2022, data_autorizacao, '16/11/2022').
contract_metadata(contrato_ocs_338_2022, ip_ati_degat, '32/2022').
contract_metadata(contrato_ocs_338_2022, data_ip_ati_degat, '11/11/2022').
contract_metadata(contrato_ocs_338_2022, rubrica_orcamentaria, '3101300003').
contract_metadata(contrato_ocs_338_2022, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_338_2022, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_338_2022, regulamento, 'Regulamento Licitações e Contratos das Empresas Integrantes do Sistema BNDES').
contract_clause(contrato_ocs_338_2022, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação continuada de serviços de acesso ao Sistema de Informações do Banco Central - SISBACEN, conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 41/2022 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_338_2022, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração:  (i) de até 3 meses, a contar da data de sua assinatura, para a implantação, incluindo todas as fases até a emissão do Termo de Recebimento Definitivo; e (ii) 60 (sessenta) meses, contados a partir da emissão do Termo de Recebimento Definitivo, no que concerne à prestação continuada do serviço objeto do Contrato.').
contract_clause(contrato_ocs_338_2022, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_338_2022, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_338_2022, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, com o apoio da Comissão de Recebimento, mencionados na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_338_2022, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 127.800,00 (cento e vinte e sete mil e oitocentos reais) conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.    Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_338_2022, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao serviço de implantação em parcela única, após a emissão do Termo de Recebimento Definitivo; e o serviço de acesso ao SISBACEN, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente  nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte da prestação do serviço/fornecimento do bem.  Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quinto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Sexto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF;  XIV. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Sétimo Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Oitavo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03.  A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Nono O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Décimo Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;  Parágrafo Décimo Primeiro Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Segundo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.    Parágrafo Décimo Terceiro Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação. Parágrafo Décimo Quarto Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_338_2022, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 05/12/2022, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação ICTI - Índice de Custo de Tecnologia da Informação divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.    Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a divulgação do índice de reajuste ocorra após o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 05/12/2022, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação ICTI - Índice de Custo de Tecnologia da Informação divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.    Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a divulgação do índice de reajuste ocorra após o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.').
contract_clause(contrato_ocs_338_2022, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_338_2022, clausula_decima_obrigações_contratado, 'CLÁUSULA DÉCIMA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XII. Fornecer todas as informações necessárias para a utilização do serviço contratado pelo BNDES (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência); XIII. Manter, durante toda a vigência do Contrato, o escalation list, para o serviço de suporte, atualizado até o nível de direção da empresa (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência); XIV. Informar e manter atualizados o CPF e nome completo do preposto da CONTRATADA perante o BNDES (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência). O preposto deverá comparecer ao BNDES para reuniões presenciais sempre que requerido pelo Gestor do Contrato (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência); XV. Não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo do BNDES ou de terceiros a que venha ter acesso por força do serviço; XVI.  Devolver, impreterivelmente, ao término do Contrato, ou a qualquer tempo a pedido do BNDES, todos os documentos que o BNDES tenha lhe fornecido; XVII. Indicar seus dados de endereço, telefone e endereço de correio eletrônico, mantendo-os atualizados perante o BNDES durante toda a vigência do Contrato (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência); XVIII. Além das obrigações usualmente aplicadas à CONTRATADA, permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017;', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XII. Fornecer todas as informações necessárias para a utilização do serviço contratado pelo BNDES (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência); XIII. Manter, durante toda a vigência do Contrato, o escalation list, para o serviço de suporte, atualizado até o nível de direção da empresa (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência); XIV. Informar e manter atualizados o CPF e nome completo do preposto da CONTRATADA perante o BNDES (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência). O preposto deverá comparecer ao BNDES para reuniões presenciais sempre que requerido pelo Gestor do Contrato (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência); XV. Não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo do BNDES ou de terceiros a que venha ter acesso por força do serviço; XVI.  Devolver, impreterivelmente, ao término do Contrato, ou a qualquer tempo a pedido do BNDES, todos os documentos que o BNDES tenha lhe fornecido; XVII. Indicar seus dados de endereço, telefone e endereço de correio eletrônico, mantendo-os atualizados perante o BNDES durante toda a vigência do Contrato (chamado com Prioridade Baixa, conforme a tabela do subitem 10.5 do Termo de Referência); XVIII. Além das obrigações usualmente aplicadas à CONTRATADA, permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017.').
contract_clause(contrato_ocs_338_2022, clausula_decima_primeira_conduta_etica, 'CLÁUSULA DÉCIMA PRIMEIRA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_338_2022, clausula_decima_segunda_sigilo, 'CLÁUSULA DÉCIMA SEGUNDA – SIGILO DAS INFORMAÇÕES Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos serviços: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo IV (Termo de Confidencialidade para Representante Legal) deste Contrato.', 'Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos serviços: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo IV (Termo de Confidencialidade para Representante Legal) deste Contrato.').
contract_clause(contrato_ocs_338_2022, clausula_decima_terceira_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA TERCEIRA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:    I. Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II. O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida;  III. O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais;  IV. O CONTRATADO se responsabilizará como “Controlador de dados” no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer aos parâmetros previstos na legislação;  V. Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto;  VI. O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos;  VII. Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação.   VIII. O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados.  IX. O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais;  X. O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais.  XI. O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas.  XII. O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais.  XIII. Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada.  XIV. Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.  Parágrafo Terceiro A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO.  Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.  Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei no 13.709/2018 (Lei Geral de Proteção de Dados-LGPD), bem como informar os titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.').
contract_clause(contrato_ocs_338_2022, clausula_decima_quarta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUARTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, José Wilson Freire de Oliveira, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; IV. designar o Fiscal do Contrato que auxiliará o Gestor do Contrato no acompanhamento, na fiscalização e na avaliação da execução do objeto;  V. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto, em conjunto com o Gestor do Contrato;  VI. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso ao Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VII. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VIII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_338_2022, clausula_decima_quinta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA QUINTA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, trabalho infantil ou trabalho escravo, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.   Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.  Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.').
contract_clause(contrato_ocs_338_2022, clausula_decima_sexta_cessão_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA SEXTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', ' É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.   Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_338_2022, clausula_decima_setima_penalidades, 'CLÁUSULA DÉCIMA SÉTIMA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos. Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).   Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_338_2022, clausula_decima_oitava_alteracoes_contratuais, 'CLÁUSULA DÉCIMA OITAVA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_338_2022, clausula_decima_nona_extincao_contrato, 'CLÁUSULA DÉCIMA NONA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_338_2022, clausula_vigésima_disposicoes_finais, 'CLÁUSULA VIGÉSIMA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência  Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_338_2022, clausula_vigésima_primeira_foro, 'CLÁUSULA VIGÉSIMA PRIMEIRA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As partes consideram, para todos os efeitos, a data da última assinatura digital como a data de formalização jurídica deste instrumento.  As folhas deste contrato foram conferidas por Marcio Oliveira da Rocha advogado do BNDES, por autorização do representante legal que o assina.      _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     _____________________________________________________________________ RTM - REDE DE TELECOMUNICACOES PARA O MERCADO LTDA                                                                                  Testemunhas:     _______________________________               _______________________________').

% ===== END =====
