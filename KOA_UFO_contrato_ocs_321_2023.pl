% ===== KOA Combined Output | contract_id: contrato_ocs_321_2023 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_321_2023_-_Software_AG.pl
% contract_id: contrato_ocs_321_2023

instance_of(contrato_ocs_321_2023, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(software_ag_brasil_informatica_e_servicos_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_321_2023).
plays_role(software_ag_brasil_informatica_e_servicos_ltda, hired_service_provider_role, contrato_ocs_321_2023).

clause_of(clausula_primeira_objeto, contrato_ocs_321_2023).
clause_of(clausula_segunda_vigencia, contrato_ocs_321_2023).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_321_2023).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_321_2023).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_321_2023).
clause_of(clausula_sexta_preco, contrato_ocs_321_2023).
clause_of(clausula_setima_pagamento, contrato_ocs_321_2023).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_321_2023).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_321_2023).
clause_of(clausula_decima_primeira_obrigações_contratado, contrato_ocs_321_2023).
clause_of(clausula_decima_segunda_conduta_etica_contratado_bndes, contrato_ocs_321_2023).
clause_of(clausula_decima_quinta_obrigações_bndes, contrato_ocs_321_2023).
clause_of(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, contrato_ocs_321_2023).
clause_of(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, contrato_ocs_321_2023).
clause_of(clausula_decima_oitava_penalidades, contrato_ocs_321_2023).
clause_of(clausula_decima_nona_alterações_contratuais, contrato_ocs_321_2023).
clause_of(clausula_vigésima_extinção_contrato, contrato_ocs_321_2023).
clause_of(clausula_vigésima_primeira_disposições_finais, contrato_ocs_321_2023).
clause_of(clausula_vigésima_segunda_foro, contrato_ocs_321_2023).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_321_2023).
clause_of(clausula_decima_terceira_sigilo_das_informacoes, contrato_ocs_321_2023).
clause_of(clausula_decima_quarta_acesso_e_protecao_de_dados_pessoais, contrato_ocs_321_2023).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, provide_support_and_updates).
legal_relation_instance(clausula_primeira_objeto, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, provide_hot_standby_licenses).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_support_and_updates).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_hot_standby_licenses).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, apresentar_manifestacao_prorrogacao).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, comunicar_interesse_prorrogacao).
legal_relation_instance(clausula_segunda_vigencia, subjection, software_ag_brasil_informatica_e_servicos_ltda, subjection_penalties_recusa_prorrogacao).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, execute_contract_object_according_to_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_contract_execution_according_to_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction_index).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, software_ag_brasil_informatica_e_servicos_ltda, be_subject_to_price_reduction_index).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, software_ag_brasil_informatica_e_servicos_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt_through_manager).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt_through_manager).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pagar_contratado).
legal_relation_instance(clausula_sexta_preco, right_to_action, software_ag_brasil_informatica_e_servicos_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bndes_pay).
legal_relation_instance(clausula_setima_pagamento, right_to_action, software_ag_brasil_informatica_e_servicos_ltda, contracted_party_receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, ensure_fiscal_document_compliance).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, return_deficient_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_overpayments).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_out_of_time_invoice).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_penalties).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, provide_digital_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, provide_supporting_documents).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_economic_financial_equilibrium).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, software_ag_brasil_informatica_e_servicos_ltda, request_price_readjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, software_ag_brasil_informatica_e_servicos_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, call_for_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, present_requested_information).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, request_price_adjustment_or_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_request_for_readjustment_or_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_deadline).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, obtain_guarantor_approval).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, notify_guarantor_insurer).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, permission_to_omit, software_ag_brasil_informatica_e_servicos_ltda, omit_guarantee_update).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, maintain_conditions_of_qualification).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, inform_penalty_imposition).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, repair_defects).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, compensate_damages).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, pay_taxes).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, assume_fiscal_responsibility).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, prove_exclusion_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, appoint_representative).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, present_dif).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, informar_bndes_conflito_interesses).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, notificar_bndes_investigacao_anticorrupcao).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_omit, software_ag_brasil_informatica_e_servicos_ltda, nao_oferecer_vantagem_indevida).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, impedir_favorecimento_participacao_sistema_bndes).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, nao_alocar_familiares_sistema_bndes).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, observar_politica_transacoes_e_codigo_etica).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, adotar_boas_praticas_sustentabilidade).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, manter_integridade_relacoes_publico_privadas).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, appoint_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, appoint_contract_manager_substitute).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_contract_information).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions_procedures).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty_application).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, right_to_action, software_ag_brasil_informatica_e_servicos_ltda, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, right_to_action, software_ag_brasil_informatica_e_servicos_ltda, receive_contract_information).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, abstain_from_discrimination).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, abstain_from_child_labor).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, abstain_from_slavery).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, abstain_from_harassment).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, abstain_from_environmental_crimes).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, software_ag_brasil_informatica_e_servicos_ltda, assign_contract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, software_ag_brasil_informatica_e_servicos_ltda, assign_contract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, software_ag_brasil_informatica_e_servicos_ltda, issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, software_ag_brasil_informatica_e_servicos_ltda, issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, software_ag_brasil_informatica_e_servicos_ltda, subcontract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, software_ag_brasil_informatica_e_servicos_ltda, subcontract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_prejudice).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, permission_to_act, software_ag_brasil_informatica_e_servicos_ltda, corporate_restructuring).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, comply_with_bndes_requirements).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, software_ag_brasil_informatica_e_servicos_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, software_ag_brasil_informatica_e_servicos_ltda, deduction_of_multa_from_credits).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_multa_from_credits).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_omit, software_ag_brasil_informatica_e_servicos_ltda, omit_actions_frustrating_bndes_licitation).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_damages_for_refusal).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages_for_refusal).
legal_relation_instance(clausula_vigésima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_consensually).
legal_relation_instance(clausula_vigésima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notification_of_termination).
legal_relation_instance(clausula_vigésima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_for_defense).
legal_relation_instance(clausula_vigésima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notice).
legal_relation_instance(clausula_vigésima_extinção_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_for_breach).
legal_relation_instance(clausula_vigésima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_of_breach).
legal_relation_instance(clausula_vigésima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_vigésima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_force_majeure).
legal_relation_instance(clausula_vigésima_primeira_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigésima_primeira_disposições_finais, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, enforce_obligations).
legal_relation_instance(clausula_vigésima_segunda_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_rio_de_janeiro_forum).
legal_relation_instance(clausula_vigésima_segunda_foro, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_subject_to_rio_de_janeiro_forum).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, bear_risks_as_allocated).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, software_ag_brasil_informatica_e_servicos_ltda, request_contract_amendment_for_allocated_risks).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_confidentiality).
legal_relation_instance(clausula_decima_quarta_acesso_e_protecao_de_dados_pessoais, duty_to_act, software_ag_brasil_informatica_e_servicos_ltda, adopt_good_governance_measures).

% --- Action catalog (local to this contract grounding) ---
action_type(abstain_from_child_labor).
action_label(abstain_from_child_labor, 'Abstain from child labor').
action_type(abstain_from_discrimination).
action_label(abstain_from_discrimination, 'Abstain from discrimination').
action_type(abstain_from_environmental_crimes).
action_label(abstain_from_environmental_crimes, 'Abstain from environmental crimes').
action_type(abstain_from_harassment).
action_label(abstain_from_harassment, 'Abstain from harassment').
action_type(abstain_from_slavery).
action_label(abstain_from_slavery, 'Abstain from slavery').
action_type(add_interest).
action_label(add_interest, 'Add interest').
action_type(adopt_good_governance_measures).
action_label(adopt_good_governance_measures, 'Adopt good governance measures').
action_type(adotar_boas_praticas_sustentabilidade).
action_label(adotar_boas_praticas_sustentabilidade, 'Adopt sustainability best practices').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_contract).
action_label(alter_contract, 'Alter contract').
action_type(analyze_request_for_readjustment_or_revision).
action_label(analyze_request_for_readjustment_or_revision, 'Duty to analyze readjustment request').
action_type(analyze_risks_prejudice).
action_label(analyze_risks_prejudice, 'Power to analyze risks').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction_index).
action_label(apply_price_reduction_index, 'Apply price reduction index').
action_type(appoint_contract_manager).
action_label(appoint_contract_manager, 'Appoint contract manager').
action_type(appoint_contract_manager_substitute).
action_label(appoint_contract_manager_substitute, 'Appoint contract manager substitute').
action_type(appoint_representative).
action_label(appoint_representative, 'Appoint representative').
action_type(apresentar_manifestacao_prorrogacao).
action_label(apresentar_manifestacao_prorrogacao, 'Present manifestation of contract renewal').
action_type(assign_contract).
action_label(assign_contract, 'No right to assign contract').
action_type(assume_fiscal_responsibility).
action_label(assume_fiscal_responsibility, 'Assume fiscal responsibility').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_price_reduction_index).
action_label(be_subject_to_price_reduction_index, 'Be subject to price reduction').
action_type(be_subject_to_rio_de_janeiro_forum).
action_label(be_subject_to_rio_de_janeiro_forum, 'Be subject to Rio de Janeiro forum.').
action_type(bear_risks_as_allocated).
action_label(bear_risks_as_allocated, 'Bear risks as allocated').
action_type(bndes_pay).
action_label(bndes_pay, 'BNDES to pay').
action_type(call_for_price_reduction).
action_label(call_for_price_reduction, 'Power to call for price reduction').
action_type(choose_rio_de_janeiro_forum).
action_label(choose_rio_de_janeiro_forum, 'Choose Rio de Janeiro forum.').
action_type(claim_damages_for_refusal).
action_label(claim_damages_for_refusal, 'Claim damages for refusal').
action_type(communicate_administrative_procedure).
action_label(communicate_administrative_procedure, 'Communicate administrative procedure').
action_type(communicate_instructions_procedures).
action_label(communicate_instructions_procedures, 'Communicate instructions/procedures').
action_type(communicate_penalty_application).
action_label(communicate_penalty_application, 'Communicate penalty application').
action_type(compensate_damages).
action_label(compensate_damages, 'Compensate damages').
action_type(compensate_damages_for_refusal).
action_label(compensate_damages_for_refusal, 'Compensate damages for refusal').
action_type(comply_with_bndes_requirements).
action_label(comply_with_bndes_requirements, 'Comply with BNDES requirements').
action_type(comunicar_interesse_prorrogacao).
action_label(comunicar_interesse_prorrogacao, 'Communicate interest in renewal').
action_type(contracted_party_receive_payment).
action_label(contracted_party_receive_payment, 'Right to receive payment').
action_type(corporate_restructuring).
action_label(corporate_restructuring, 'Permitted to restructure').
action_type(deduct_multa_from_credits).
action_label(deduct_multa_from_credits, 'Deduct multa from credits').
action_type(deduct_overpayments).
action_label(deduct_overpayments, 'Deduct overpayments').
action_type(deduct_penalties).
action_label(deduct_penalties, 'Deduct penalties').
action_type(deduction_of_multa_from_credits).
action_label(deduction_of_multa_from_credits, 'Deduction of multa from credits').
action_type(defend_demand).
action_label(defend_demand, 'Defend demand').
action_type(demand_confidentiality).
action_label(demand_confidentiality, 'Demand confidentiality').
action_type(demand_contractual_guarantee).
action_label(demand_contractual_guarantee, 'Demand guarantee').
action_type(demand_services_according_to_standards).
action_label(demand_services_according_to_standards, 'Demand services to standards').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(effect_object_receipt_through_manager).
action_label(effect_object_receipt_through_manager, 'Effect object receipt through manager').
action_type(enforce_obligations).
action_label(enforce_obligations, 'Enforce obligations').
action_type(ensure_fiscal_document_compliance).
action_label(ensure_fiscal_document_compliance, 'Ensure fiscal document compliance').
action_type(execute_contract_object_according_to_specifications).
action_label(execute_contract_object_according_to_specifications, 'Execute object per specifications').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services to standards').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(expect_contract_execution_according_to_specifications).
action_label(expect_contract_execution_according_to_specifications, 'Expect execution per specifications').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(guarantee_no_infringement).
action_label(guarantee_no_infringement, 'Guarantee no infringement').
action_type(impedir_favorecimento_participacao_sistema_bndes).
action_label(impedir_favorecimento_participacao_sistema_bndes, 'Prevent BNDES employee involvement').
action_type(inform_penalty_imposition).
action_label(inform_penalty_imposition, 'Inform penalty imposition').
action_type(informar_bndes_conflito_interesses).
action_label(informar_bndes_conflito_interesses, 'Inform BNDES of conflict of interest').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'Right to initiate price revision').
action_type(issue_credit_title).
action_label(issue_credit_title, 'No right to issue credit title').
action_type(maintain_conditions_of_qualification).
action_label(maintain_conditions_of_qualification, 'Maintain qualification conditions').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(make_payments_to_contracted).
action_label(make_payments_to_contracted, 'Make payments to contracted').
action_type(manter_integridade_relacoes_publico_privadas).
action_label(manter_integridade_relacoes_publico_privadas, 'Maintain integrity in public-private relations').
action_type(nao_alocar_familiares_sistema_bndes).
action_label(nao_alocar_familiares_sistema_bndes, 'Do not allocate BNDES relatives').
action_type(nao_oferecer_vantagem_indevida).
action_label(nao_oferecer_vantagem_indevida, 'Do not offer undue advantage').
action_type(notificar_bndes_investigacao_anticorrupcao).
action_label(notificar_bndes_investigacao_anticorrupcao, 'Notify BNDES of anti-corruption investigation').
action_type(notify_guarantor_insurer).
action_label(notify_guarantor_insurer, 'Notify guarantor/insurer').
action_type(notify_of_breach).
action_label(notify_of_breach, 'Notify of breach').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observar_politica_transacoes_e_codigo_etica).
action_label(observar_politica_transacoes_e_codigo_etica, 'Observe policies and code of ethics').
action_type(obtain_guarantor_approval).
action_label(obtain_guarantor_approval, 'Obtain guarantor approval').
action_type(omit_actions_frustrating_bndes_licitation).
action_label(omit_actions_frustrating_bndes_licitation, 'Don\'t frustrate BNDES licitation').
action_type(omit_guarantee_update).
action_label(omit_guarantee_update, 'Omit guarantee update').
action_type(pagar_contratado).
action_label(pagar_contratado, 'Pay the contracted party').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_requested_information).
action_label(present_requested_information, 'Duty to present requested information').
action_type(prove_exclusion_from_simples_nacional).
action_label(prove_exclusion_from_simples_nacional, 'Prove exclusion from Simples Nacional').
action_type(provide_contract_information).
action_label(provide_contract_information, 'Provide contract info').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_digital_fiscal_document).
action_label(provide_digital_fiscal_document, 'Provide digital fiscal document').
action_type(provide_hot_standby_licenses).
action_label(provide_hot_standby_licenses, 'Provide Hot Standby licenses').
action_type(provide_opportunity_for_defense).
action_label(provide_opportunity_for_defense, 'Provide opportunity for defense').
action_type(provide_support_and_updates).
action_label(provide_support_and_updates, 'Provide support and updates').
action_type(provide_supporting_documents).
action_label(provide_supporting_documents, 'Provide supporting documents').
action_type(provide_written_notice).
action_label(provide_written_notice, 'Provide written notice').
action_type(provide_written_notification_of_termination).
action_label(provide_written_notification_of_termination, 'Provide written termination notice').
action_type(receive_contract_information).
action_label(receive_contract_information, 'Receive contract information').
action_type(receive_hot_standby_licenses).
action_label(receive_hot_standby_licenses, 'Receive Hot Standby licenses').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments from BNDES').
action_type(receive_support_and_updates).
action_label(receive_support_and_updates, 'Receive support and updates').
action_type(reject_out_of_time_invoice).
action_label(reject_out_of_time_invoice, 'Reject out-of-time invoice').
action_type(repair_defects).
action_label(repair_defects, 'Repair defects').
action_type(request_contract_amendment_for_allocated_risks).
action_label(request_contract_amendment_for_allocated_risks, 'No right to amend for allocated risks').
action_type(request_price_adjustment_or_revision).
action_label(request_price_adjustment_or_revision, 'Duty to request price adjustment').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'Right to request price readjustment').
action_type(request_price_revision).
action_label(request_price_revision, 'Right to request price revision').
action_type(require_proof_of_regularity).
action_label(require_proof_of_regularity, 'Require proof of regularity').
action_type(return_deficient_fiscal_document).
action_label(return_deficient_fiscal_document, 'Return deficient fiscal document').
action_type(right_to_economic_financial_equilibrium).
action_label(right_to_economic_financial_equilibrium, 'Right to economic-financial equilibrium').
action_type(subcontract).
action_label(subcontract, 'No right to subcontract').
action_type(subjection_penalties_recusa_prorrogacao).
action_label(subjection_penalties_recusa_prorrogacao, 'Subject to penalties for refusing renewal').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(suspend_deadline).
action_label(suspend_deadline, 'Permission to suspend deadline').
action_type(terminate_contract_consensually).
action_label(terminate_contract_consensually, 'Terminate contract consensually').
action_type(terminate_contract_due_to_force_majeure).
action_label(terminate_contract_due_to_force_majeure, 'Terminate for force majeure').
action_type(terminate_contract_for_breach).
action_label(terminate_contract_for_breach, 'Terminate for breach').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_321_2023).
contract_metadata(contrato_ocs_321_2023, numero_ocs, '321/2023').
contract_metadata(contrato_ocs_321_2023, numero_sap, '4400005727').
contract_metadata(contrato_ocs_321_2023, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_321_2023, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'SOFTWARE AG BRASIL INFORMÁTICA E SERVIÇOS LTDA']).
contract_metadata(contrato_ocs_321_2023, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_321_2023, contratado, 'SOFTWARE AG BRASIL INFORMÁTICA E SERVIÇOS LTDA').
contract_metadata(contrato_ocs_321_2023, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_321_2023, cnpj_contratado, '07.594.862/0001-39').
contract_metadata(contrato_ocs_321_2023, data_autorizacao, '04/12/2023').
contract_metadata(contrato_ocs_321_2023, ip_ati_degat, '013/2023').
contract_metadata(contrato_ocs_321_2023, data_ip_ati_degat, '01/12/2023').
contract_metadata(contrato_ocs_321_2023, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_321_2023, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_321_2023, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_metadata(contrato_ocs_321_2023, centro_custo, 'BN00004000').
contract_metadata_raw(contrato_ocs_321_2023, 'centro de custo nº BN00004000 – CCTI1 e BN30005000 (ATI/DESET)', 'BN00004000 – CCTI1 e BN30005000 (ATI/DESET)', 'preamble').
contract_metadata_raw(contrato_ocs_321_2023, 'rubrica ns° 3101700021 e 1800100021', '3101700021 e 1800100021', 'preamble').
contract_clause(contrato_ocs_321_2023, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação continuada de serviços de suporte e atualização para os softwares utilizados no desenvolvimento de sistemas no Mainframe (Natural, Adabas e correlatos) e aquisição de licenças do tipo Hot Standby, conforme especificações constantes do Termo de Referência e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_321_2023, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 24 (vinte e quatro) meses, a contar da data de sua assinatura, podendo ser prorrogado, mediante aditivo, até o limite total de 60 (sessenta) meses.  Parágrafo Primeiro O CONTRATADO deverá, no prazo de até 5 (cinco) dias úteis, contados da notificação do Gestor do Contrato, apresentar, por intermédio do seu Representante Legal, sua manifestação sobre a prorrogação do Contrato.  Parágrafo Segundo Independente da notificação do parágrafo anterior, o CONTRATADO deverá comunicar ao Gestor seu interesse quanto à prorrogação do contrato até 90 (noventa) dias antes do término de cada período de vigência contratual.  Parágrafo Terceiro A formalização da prorrogação será efetuada por meio de aditivo epistolar, dispensando-se a assinatura do CONTRATADO, desde que mantidas as mesmas condições de utilização dos softwares licenciados sob este Contrato sem nenhuma violação de propriedade intelectual do CONTRATADO.  Parágrafo Quarto Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_321_2023, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_321_2023, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) e Anexo II (Proposta) deste Contrato.  Parágrafo Primeiro O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.   Parágrafo Segundo O descumprimento dos níveis de serviço deve ser devidamente demonstrado e documentado, sendo que a redução será aplicada apenas após as considerações do Gestor do Contrato sobre as justificativas apresentadas pela CONTRATADA.').
contract_clause(contrato_ocs_321_2023, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_321_2023, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 8.963.006,56 (oito milhões, novecentos e sessenta e três mil, seis reais e cinquenta e seis centavos), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.   Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.').
contract_clause(contrato_ocs_321_2023, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato da seguinte forma: I. Quanto ao fornecimento das licenças de software, em parcela única, por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento. II. Quanto aos serviços de Manutenção e Suporte Técnico Remoto, o pagamento se dará mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte da prestação do serviço/fornecimento do bem.   Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quinto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Sexto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF;  XIV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Sétimo Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Oitavo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Nono O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Décimo Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;  Parágrafo Décimo Primeiro Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Segundo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Terceiro Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.  Parágrafo Décimo Quarto Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_321_2023, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 07/08/2023, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo da Tecnologia da Informação – ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, acumulado no respectivo período, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato.').
contract_clause(contrato_ocs_321_2023, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_321_2023, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL', ' O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 448.150,33(quatrocentos e quarenta e oito mil, cento e cinquenta reais e trinta e três centavos) em uma das modalidades dispostas abaixo, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.   Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.  Parágrafo Quinto A garantia contratual deverá cobrir: I. todas as obrigações decorrentes do objeto contratual, assim como eventuais danos decorrentes de seu descumprimento; II. todas as obrigações relacionadas ao objeto principal, ainda que decorrentes de sua manutenção e/ou refazimento, bem como das medidas necessárias à prevenção ordinária de sinistros, prejuízos e danos em geral; III. prejuízos decorrentes de atos de corrupção praticados sem participação dolosa do BNDES ou de seus representantes; IV. prejuízos diretos causados ao BNDES decorrentes de culpa ou dolo durante a execução do Contrato; V. multas moratórias e/ou punitivas aplicadas pelo BNDES ao CONTRATADO;  VI. obrigações trabalhistas e previdenciárias de qualquer natureza, não adimplidas pelo CONTRATADO, quando o objeto contratual demandar cessão de mão de obra com dedicação exclusiva.   Parágrafo Sexto Em caso de prorrogação da vigência ou alteração do objeto contratual, o CONTRATADO deverá notificar a entidade fiadora/seguradora, conforme o caso, no prazo de até 10 (dez) dias úteis, contados da formalização do respectivo Instrumento Contratual.  Parágrafo Sétimo Por se tratar de garantia contratual prestada em benefício de uma Estatal, caso os documentos de caução, fiança ou seguro façam referência à Lei nº 8.666/1993 e/ou à Lei nº 14.133/2021, aplicam-se as disposições respectivas da Lei nº 13.303/2016, no que couber.').
contract_clause(contrato_ocs_321_2023, clausula_decima_primeira_obrigações_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, desde que o BNDES: i) notifique prontamente o CONTRATADO de tal ação; (ii) dê ao CONTRATADO total autoridade, informação e assistência para defender tal demanda; e (iii) dê ao CONTRATADO controle exclusivo da defesa de tal demanda e de todas as negociações para a realização de um acordo em tal demanda.  O CONTRATADO não terá obrigação de indenizar ou qualquer outra responsabilidade sob este Contrato na medida em que a demanda é baseada em: (i) Software que foi alterado por qualquer pessoa que não o CONTRATADO; (ii) uso de outro release que não o mais recente do Software, caso a infração pudesse ser evitada pelo uso do release mais recente e que tal release tenha sido disponibilizado ao BNDES e este tenha sido notificado formalmente; (iii) uso do Software em conjunto com outro software, hardware ou dados do BNDES, de que forma que esse uso deu causa à demanda por violação; (iv) uso do Software de forma inconsistente com sua Documentação; ou (v) uso do Software de forma diversa da expressamente autorizada neste Contrato.', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, desde que o BNDES: i) notifique prontamente o CONTRATADO de tal ação; (ii) dê ao CONTRATADO total autoridade, informação e assistência para defender tal demanda; e (iii) dê ao CONTRATADO controle exclusivo da defesa de tal demanda e de todas as negociações para a realização de um acordo em tal demanda.  O CONTRATADO não terá obrigação de indenizar ou qualquer outra responsabilidade sob este Contrato na medida em que a demanda é baseada em: (i) Software que foi alterado por qualquer pessoa que não o CONTRATADO; (ii) uso de outro release que não o mais recente do Software, caso a infração pudesse ser evitada pelo uso do release mais recente e que tal release tenha sido disponibilizado ao BNDES e este tenha sido notificado formalmente; (iii) uso do Software em conjunto com outro software, hardware ou dados do BNDES, de que forma que esse uso deu causa à demanda por violação; (iv) uso do Software de forma inconsistente com sua Documentação; ou (v) uso do Software de forma diversa da expressamente autorizada neste Contrato.', 'clausula_decima_primeira_obrigacoes_contratado').
contract_clause(contrato_ocs_321_2023, clausula_decima_segunda_conduta_etica_contratado_bndes, 'CLÁUSULA DÉCIMA SEGUNDA– CONDUTA ÉTICA DO CONTRATADO E DO BNDES O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política Corporativa de Integridade do Sistema BNDES, assegurando-se de que seus representantes legais e administradores pautem seu comportamento e sua atuação pelos princípios neles constantes;  V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição;  VI. informar imediatamente ao BNDES a ocorrência de potencial situação de conflito de interesses, comunicando na mesma oportunidade as medidas que serão adotadas para o tratamento da questão; e VII. notificar imediatamente o BNDES sobre qualquer investigação ou procedimento iniciado por autoridade governamental relacionado à violação de Leis Anticorrupção (nacional ou estrangeira) e/ou de obrigações da empresa, de seus administradores, diretores, prepostos, empregados, representantes ou terceiros a seu serviço, incluindo subcontratados, referentes a este Contrato. Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política Corporativa de Integridade do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política Corporativa de Integridade do Sistema BNDES, assegurando-se de que seus representantes legais e administradores pautem seu comportamento e sua atuação pelos princípios neles constantes;  V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição;  VI. informar imediatamente ao BNDES a ocorrência de potencial situação de conflito de interesses, comunicando na mesma oportunidade as medidas que serão adotadas para o tratamento da questão; e VII. notificar imediatamente o BNDES sobre qualquer investigação ou procedimento iniciado por autoridade governamental relacionado à violação de Leis Anticorrupção (nacional ou estrangeira) e/ou de obrigações da empresa, de seus administradores, diretores, prepostos, empregados, representantes ou terceiros a seu serviço, incluindo subcontratados, referentes a este Contrato. Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política Corporativa de Integridade do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).', 'clausula_decima_segunda_conduta_etica_contratado_bndes').
contract_clause(contrato_ocs_321_2023, clausula_decima_terceira_sigilo_das_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.  Parágrafo Primeiro Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal, do Termo de Confidencialidade a ser disponibilizado pelo BNDES.  Parágrafo Segundo Considerando as especificidades técnicas do objeto deste contrato, as Partes acordam as seguintes observações à Política Corporativa de Segurança da Informação do BNDES:  Política de Segurança da Informação do BNDES - Cláusula Observações 4.2.2.  O acesso a informações sigilosas deve ser precedido da assinatura de um Termo de Confidencialidade baseado, conforme o caso, em um dos modelos anexos a essa Resolução e listados a seguir: Considerando que no contrato já elucidamos o fato que não haverá pessoa natural alocada, com a exclusão da assinatura de um termo de confidencialidade por pessoa natural, entendemos que este item não é aplicável devendo ser aplicado a cláusula 13ª, caput, deste Contrato que já estabelece o dever de confidencialidade. 4.4.2. As informações devem ser classificadas e tratadas segundo critérios e procedimentos estabelecidos em normativo próprio, atualmente a OS PRESI BNDES nº 01, de 22/01/2015, e suas eventuais alterações posteriores. Se e quando for necessário tratamento específico para os dados de diagnóstico apresentados, o BNDES informará explicitamente e previamente a Software AG. 5. Papéis e responsabilidades A Software AG reitera que os papéis e responsabilidades deste item são aplicáveis a estrutura interna do BNDES. 5.16 Cabe aos colaboradores: b) participar na realização de testes e treinamentos de segurança da informação,  quando solicitado pelo AIC/DEROC; e Considerando que no contrato já elucidamos o fato que não haverá pessoa natural alocada, entendemos que este item não é aplicável ao objeto do contrato. 6.1   As Empresas do Sistema BNDES podem, a seu critério e, observadas as disposições da Lei nº 13.709, de 2018, bem como as regras estabelecidas pela PCPD, monitorar e registrar a  Tal disposição não é aplicável ao contrato, uma vez que o objeto do contrato ora negociado não contempla acesso da Software AG ao ambiente de TI do BNDES. manipulação de Ativos de Informação armazenados ou em trânsito, com o objetivo de zelar pelo fiel cumprimento da PCSI. 8.1 O descumprimento da PCSI pode acarretar responsabilização, nos termos dos respectivos regulamentos de pessoal dos Planos de Cargos e Salários das Empresas do Sistema BNDES e nos termos dos contratos ou convênios para estagiários, menores aprendizes, empresas prestadoras de serviço e seus empregados, sem prejuízo das responsabilidades civis e penais eventualmente cabíveis. A responsabilidade prevista na PCSI terá como referência as condições estabelecidas na cláusula 11ª, IV deste Contrato. Anexos II, III, IV, V, VI – Termo de Confidencialidade e Tratamento de Dados Pessoais para Contratos Administrativos, Termo de Confidencialidade e Tratamento de Dados Pessoais para Participantes do Sistema BNDES, Termo de Confidencialidade e Tratamento de Dados Pessoais para Profissionais Terceirizados, Termo de Confidencialidade e Tratamento de Dados Pessoais (para pessoa física) Considerando que no contrato já elucidamos o fato que não haverá pessoa natural alocada, com a exclusão da assinatura de um termo de confidencialidade por pessoa natural, entendemos que este item não é aplicável devendo ser aplicado a cláusula 13ª, caput, deste Contrato que já estabelece o dever de confidencialidade. Anexos VII, VIII, IX, X, XI, XII, XIII, XIV, XV, XVI – Acesso a Áreas com Ativos Críticos de TI, Normas de segurança para Acesso Remoto a Ativos de Tecnologia da Informação, Controle de Acesso à Informação, Norma para Gestão dos Serviços de Segurança da Informação, Uso da Internet, Uso de Ativos de Tecnologia da Informação,  Considerando que o contrato ora negociado não contempla acesso da Software AG ao ambiente do BNDES, os Anexos VII, VIII, IX, X, XI, XII, XIII, XIV, XV, XVI – Acesso a Áreas com Ativos Críticos de TI, Normas de segurança para Acesso Remoto a Ativos de Tecnologia da Informação, Controle de Acesso à Informação, Norma para Administração de Ativos de Tecnologia da Informação, Uso do Correio Eletrônico, Uso de Dispositivo Pessoais Gestão dos Serviços de Segurança da Informação, Uso da Internet, Uso de Ativos de Tecnologia da Informação, Administração de Ativos de Tecnologia da Informação, Uso do Correio Eletrônico, Uso de Dispositivo Pessoais, Uso de Serviços de Processamento, Armazenamento e Transmissão de Dados e de Computação em Nuvem, não são aplicáveis. Se e quando for necessário tratamento específico para os dados de diagnóstico apresentados, o BNDES informará explicitamente e previamente a Software AG.');
contract_clause(contrato_ocs_321_2023, clausula_decima_quarta_acesso_e_protecao_de_dados_pessoais, 'CLÁUSULA DÉCIMA QUARTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas de boa governança sob o aspecto técnico, jurídico e administrativo, inclusive de segurança, e observar que:   I.Eventual tratamento de dados pessoais em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados Pessoais - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;  II.O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória,  III.O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais; IV.Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação;  V.O CONTRATADO dará conhecimento formal para seus empregados acerca da Proteção à Privacidade nos termos da legislação aplicável, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados; VI.Na hipótese de o Contratado deixar de observar as obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais, e na medida que tal descumprimento venha a causar danos efetivos e comprovados ao BNDES, o BNDES possuirá direito de regresso em face do CONTRATADO; VII.O CONTRATADO cooperará com o BNDES no cumprimento das obrigações relacionadas ao exercício de direitos do titular do dado, para viabilizar o atendimento tempestivo do BNDES às requisições dos titulares que estejam relacionadas às atividades de tratamento executadas pelo CONTRATADO no âmbito deste Contrato; VIII.O CONTRATADO deverá informar prontamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, e se abster de responder diretamente a qualquer solicitação e/ou requisição feita pelo titular, exceto quando solicitado expressamente pelo BNDES e pela legislação em vigor; IX.O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais; X.Qualquer incidente ao qual o CONTRATADO tiver dado causa e que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada; XI.Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, responderá solidariamente junto ao BNDES por eventuais danos causados.  Parágrafo Segundo Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Terceiro O BNDES se compromete a coletar o consentimento, quando necessário, conforme previsto na Lei nº 13.709/2018 (Lei Geral de Proteção de Dados Pessoais - LGPD), bem como informar aos titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.  Parágrafo Quarto Na prestação de Serviços, os dados pessoais serão transferidos para Países Terceiros pela CONTRATADA em conformidade com o Capítulo V da GDPR. O BNDES concorda que, quando a SOFTWARE AG contratar um Subprocessador, para a prestação de Serviços e eles envolverem uma transferência de dados pessoais dentro do significado do Capítulo V da GDPR, a CONTRATADA e o Subprocessador podem assegurar a conformidade com o Capítulo V da GDPR, (i) por exemplo, usando as CCPs e quando necessário (ii) que suplementos adicionais contratuais, organizacionais e medidas técnicas estão em vigor para fornecer um nível suficiente de proteção de dados.');
contract_clause(contrato_ocs_321_2023, clausula_decima_quinta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Alexandre Britto Goulart, que atualmente exerce a função de Coordenador de Serviço, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência, o funcionário Daniel da Cunha Schmidt; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso ao Código de Ética do Sistema BNDES, da Política Corporativa de Integridade do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VI. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_321_2023, clausula_decima_sexta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SEXTA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'As partes deverão se abster de práticas de discriminação de raça ou gênero, exploração irregular, ilegal ou criminosa do trabalho infantil ou prática relacionada ao trabalho em condições análogas à escravidão, e de outras ações que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente, buscando promover uma cultura de integridade e inclusão em suas atividades diárias e assegurando que suas práticas de negócios estejam baseadas em políticas responsáveis com adesão aos mais altos padrões de ética.').
contract_clause(contrato_ocs_321_2023, clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA SÉTIMA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.     Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_321_2023, clausula_decima_oitava_penalidades, 'CLÁUSULA DÉCIMA OITAVA– PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III do caput desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.  Parágrafo Nono O total das multas aplicadas não poderá exceder o montante de 30% (trinta por cento) do valor global do Contrato durante a vigência contratual.').
contract_clause(contrato_ocs_321_2023, clausula_decima_nona_alterações_contratuais, 'CLÁUSULA DÉCIMA NONA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_321_2023, clausula_vigésima_extinção_contrato, 'CLÁUSULA VIGÉSIMA– EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  V. quando for decretada a falência do CONTRATADO; VI. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VII. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VIII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  IX. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; X. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato;  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_321_2023, clausula_vigésima_primeira_disposições_finais, 'CLÁUSULA VIGÉSIMA PRIMEIRA – DISPOSIÇÕES FINAIS', 'O Contratado reconhece a regularidade da utilização pretérita de seus produtos pelo BNDES no data center alternativo, abrangendo o licenciamento e a prestação do serviço de atualização técnica, suporte técnico remoto e manutenção corretiva.  Parágrafo Primeiro Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto, integrando o presente Contrato:  Anexo I - Termo de Referência  Anexo II - Proposta Anexo III - Matriz de Risco  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_321_2023, clausula_vigésima_segunda_foro, 'CLÁUSULA VIGÉSIMA SEGUNDA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As partes consideram, para todos os efeitos, a data da última assinatura como a data de formalização jurídica deste instrumento.  As folhas deste contrato foram conferidas por Lara Godoy dos Santos Ferreira Rodrigues, advogada do BNDES, por autorização do representante legal que o assina.   _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES   _____________________________________________________________________ SOFTWARE AG BRASIL INFORMÁTICA E SERVIÇOS LTDA.  Testemunhas:   __________________________________  __________________________________').

% ===== END =====
